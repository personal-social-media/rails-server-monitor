# frozen_string_literal: true

module RailsServerMonitor
  class Server < ApplicationRecord
    self.table_name = "rails_server_monitor_servers"
    store :system_information, accessors: %i(
      system_os
      system_os_language
      system_os_timezone
      system_kernel_version
      system_cpu_name
      system_cpu_cores
      system_cpu_frequency
      system_ram_available_in_mb
      system_hdd_available_in_gb
    ), coder: JSON

    belongs_to :group, class_name: "RailsServerMonitor::ServerGroup", counter_cache: true, optional: true
    has_many :server_snapshots, class_name: "RailsServerMonitor::ServerSnapshot",
             foreign_key: :rails_server_monitor_server_id,
             dependent: :delete_all

    def display_name
      @display_name ||= custom_name.present? ? custom_name : hostname
    end
  end
end
