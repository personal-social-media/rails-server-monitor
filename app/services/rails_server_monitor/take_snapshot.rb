# frozen_string_literal: true

module RailsServerMonitor
  class TakeSnapshot
    attr_reader :server

    def initialize(server)
      @server = server
    end

    def call
      return unless can_take_snapshot?
      create_snapshot!
    end

    def can_take_snapshot?
      return @can_take_snapshot if defined? @can_take_snapshot
      latest_snapshot = server.server_snapshots.order(id: :desc).first
      if latest_snapshot.blank?
        return @can_take_snapshot = true
      end
      if (Time.zone.now - latest_snapshot.created_at) >= config.snapshot_server_interval
        return @can_take_snapshot = true
      end

      @can_take_snapshot = false
    end

    private
      def create_snapshot!
        RailsServerMonitor::ServerSnapshot.create!(
          cpu_usage_percentage: cpu_usage_percentage,
          ram_usage_percentage: ram_usage_percentage,
          hdd_usage_percentage: hdd_usage_percentage,
          ram_stats: ram_stats,
          hdd_stats: hdd_stats,
          network_stats: network_stats,
          rails_server_monitor_server: server
        )
      end

      def cpu_usage_percentage
        psm_helper.uw_cpuused
      end

      def ram_usage_percentage
        percentage_off(ram_helper[:total], ram_helper[:used])
      end

      def hdd_usage_percentage
        percentage_off(storage_helper[:total], storage_helper[:used])
      end

      def ram_stats
        ram_helper.slice(:used, :free)
      end

      def hdd_stats
        storage_helper.slice(:used, :free)
      end

      def network_stats
      end

      def psm_helper
        RubyStatsPsm
      end

      def config
        RailsServerMonitor.config
      end

      def storage_helper
        @store ||= Vidibus::Sysinfo.storage.to_h
      end

      def ram_helper
        @ram_helper ||= Vidibus::Sysinfo.memory.to_h
      end

      def percentage_off(total, current)
        ((current / total.to_f) * 100).round
      end
  end
end
