# frozen_string_literal: true

module RailsServerMonitor
  class Cleanup
    def call
      RailsServerMonitor::ServerSnapshot.where("created_at < ?", Time.zone.now - config.cleanup_snapshots_after)
                                        .delete_all
    end

    def config
      RailsServerMonitor.config
    end
  end
end
