# frozen_string_literal: true

require "rails"
require_relative "./engine"
module RailsServerMonitor
  class CompileLocally
    class << self
      def compile
        new.compile(skip_check: true)
      end

      def compile_force
        new.compile(skip_check: false)
      end
    end

    def compile(skip_check:)
      unless skip_check
        return unless Rails.env.development? || Rails.env.test?
      end
      return if Dir.exist?(RailsServerMonitor::Engine.root.join("public", "rails-server-monitor-packs"))

      RailsServerMonitor.webpacker.commands.compile
    end
  end
end
