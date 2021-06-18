# frozen_string_literal: true

module RailsServerMonitor
  module Warnings
    class LowDiskSpaceComponent < ViewComponent::Base
      attr_reader :ctx
      def initialize(ctx:)
        @ctx = ctx
      end

      def scope
        @scope ||= RailsServerMonitor::ServerSnapshot
                     .includes(:rails_server_monitor_server)
                     .where("hdd_usage_percentage >= ?", max_space_usage)
                     .where("created_at > ?", 3.days.ago)
                     .limit(100)
      end

      def config
        RailsServerMonitor.config
      end

      def max_space_usage
        100 - config.low_free_disk_disk_threshold
      end
    end
  end
end
