# frozen_string_literal: true

module RailsServerMonitor
  module Warnings
    class HighCpuUsageComponent < ViewComponent::Base
      attr_reader :ctx
      def initialize(ctx:)
        @ctx = ctx
      end

      def scope
        @scope ||= RailsServerMonitor::ServerSnapshot
                     .includes(:rails_server_monitor_server)
                     .where("cpu_usage_percentage >= ?", config.high_cpu_usage_threshold)
                     .where("created_at > ?", 3.days.ago)
                     .limit(100)
      end

      def config
        RailsServerMonitor.config
      end
    end
  end
end
