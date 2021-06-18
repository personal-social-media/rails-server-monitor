module RailsServerMonitor
  class Configuration
    attr_writer :update_server_interval, :snapshot_server_interval, :ignore_urls

    def update_server_interval
      @update_server_interval || 1.hour
    end

    def snapshot_server_interval
      @snapshot_server_interval || 15.minutes
    end
  end
end