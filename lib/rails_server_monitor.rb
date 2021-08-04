# frozen_string_literal: true

require_relative "./rails_server_monitor/version"
require_relative "./rails_server_monitor/engine"
require_relative "./rails_server_monitor/configuration"
require_relative "./rails_server_monitor/compile_locally"
require_relative "../app/middlewares/rails_server_monitor/rack_middleware"
require "sys/cpu"
require "rubystats_psm"
require "vidibus-sysinfo"
require "view_component/engine"
require "groupdate"
require "chartkick"
require "webpacker"

module RailsServerMonitor
  ROOT_PATH = Pathname.new(File.join(__dir__, ".."))

  class << self
    def webpacker
      @webpacker ||= Webpacker::Instance.new(
        root_path: RailsServerMonitor::Engine.root,
        config_path: RailsServerMonitor::Engine.root.join("config", "webpacker.yml")
      )
    end

    def config
      unless block_given?
        return @configuration ||= Configuration.new
      end

      @configuration = Configuration.new
      yield @configuration
    end
  end
end
