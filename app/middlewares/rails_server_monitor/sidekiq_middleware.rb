# frozen_string_literal: true

module RailsServerMonitor
  class SidekiqMiddleware
    def call(worker, *_)
      return yield if ignore_worker?(worker)

      yield.tap do
        server = RailsServerMonitor::ServerSetup.new.call
        snapshot = RailsServerMonitor::TakeSnapshot.new(server)

        if snapshot.can_take_snapshot?
          snapshot.call

          RailsServerMonitor::Cleanup.new.call
        end
      end
    end

    def ignore_worker?(worker)
      return false if config.ignore_workers.blank?
      klass_name = worker.class.name

      config.ignore_workers.include?(klass_name)
    end

    def config
      RailsServerMonitor.config
    end
  end
end
