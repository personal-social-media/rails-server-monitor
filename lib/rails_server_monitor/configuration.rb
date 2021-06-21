# frozen_string_literal: true

module RailsServerMonitor
  class Configuration
    attr_writer :update_server_interval, :snapshot_server_interval, :ignore_urls,
                :cleanup_snapshots_after, :ignore_workers, :high_cpu_usage_threshold,
                :low_memory_threshold, :low_free_disk_disk_threshold, :hostname

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

    def ignore_workers
      @ignore_workers || []
    end

    def high_cpu_usage_threshold
      @high_cpu_usage_threshold || 95
    end

    def low_memory_threshold
      @low_memory_threshold || 20
    end

    def low_free_disk_disk_threshold
      @low_free_disk_disk_threshold || 30
    end

    def hostname
      -> { `hostname` }
    end
  end
end
