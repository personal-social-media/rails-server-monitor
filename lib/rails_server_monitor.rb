# frozen_string_literal: true

require_relative "./rails_server_monitor/version"
require_relative "./rails_server_monitor/engine"

module RailsServerMonitor
  ROOT_PATH = Pathname.new(File.join(__dir__, ".."))

  class << self
    def webpacker
      @webpacker ||= ::Webpacker::Instance.new(
        root_path: RailsServerMonitor::Engine.root,
        config_path: RailsServerMonitor::Engine.root.join("config", "webpacker.yml")
      )
    end
  end
end
