module RailsServerMonitor
  class ServerSetup
    attr_reader :server

    def initialize
      @server = RailsServerMonitor::Server.find_or_initialize_by(hostname: hostname)
    end

    def call
      server.tap do
        next update_server if server.updated_at.blank?

        needs_update = (server.updated_at - Time.zone.now) > config.update_server_interval
        update_server if needs_update
      end
    end

    private

    def hostname
      @hostname ||= `hostname`
    end

    def update_server
      server.assign_attributes({
        last_seen_at: Time.zone.now,
        system_os: system_os,
        system_os_language: system_os_language,
        system_os_timezone: system_os_timezone,
        system_kernel_version: system_kernel_version,
        system_cpu_name: system_cpu_name,
        system_cpu_cores: system_cpu_cores,
        system_cpu_frequency: system_cpu_frequency
      })

      server.save!
    end

    def system_os
      File.read("/etc/lsb-release")
    end

    def system_os_language
      ENV["LANG"]
    end

    def system_os_timezone
      File.read("/etc/timezone")
    end

    def system_kernel_version
      `uname -r`
    end

    def system_cpu_name
      Sys::CPU.model
    end

    def system_cpu_cores
      Sys::CPU.num_cpu
    end

    def system_cpu_frequency
      Sys::CPU.freq
    end

    def config
      RailsServerMonitor.config
    end
  end
end