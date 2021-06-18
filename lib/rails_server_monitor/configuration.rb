# frozen_string_literal: true

module RailsServerMonitor
  class Configuration
    attr_writer :update_server_interval, :snapshot_server_interval, :ignore_urls, :cleanup_snapshots_after

    def update_server_interval
      @update_server_interval || 1.hour
    end

    def snapshot_server_interval
      @snapshot_server_interval || 15.minutes
    end

    def cleanup_snapshots_after
      @cleanup_snapshots_after || 30.days
    end

    def ignore_urls
      @ignore_urls || []
    end
  end
end
