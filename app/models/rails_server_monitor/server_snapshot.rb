# frozen_string_literal: true

module RailsServerMonitor
  class ServerSnapshot < ApplicationRecord
    self.table_name = "rails_server_monitor_server_snapshots"

    belongs_to :rails_server_monitor_server, class_name: "RailsServerMonitor::Server"

    serialize :ram_stats, JSON
    serialize :hdd_stats, JSON
  end
end
