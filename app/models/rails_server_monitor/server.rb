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
    ), coder: JSON
  end
end
