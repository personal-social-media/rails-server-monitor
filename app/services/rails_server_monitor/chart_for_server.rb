module RailsServerMonitor
  class ChartForServer
    attr_reader :server, :timeline
    def initialize(server, timeline: :today)
      @server = server
      @timeline = timeline
    end

    def render_chart
      [
        {
          name: "% CPU usage", data: fill_hash_for_attribute(:cpu_usage_percentage),
        },
        {
          name: "% RAM usage", data: fill_hash_for_attribute(:ram_usage_percentage)
        },
        {
          name: "% HDD usage", data: fill_hash_for_attribute(:hdd_usage_percentage)
        }
      ]
    end

    def today?
      timeline == :today
    end


    def last_record
      @last_record = scope.last
    end

    def scope
      return @scope if defined? @scope
      query = server.server_snapshots.order(id: :asc)
      if today?
        query = query.where("created_at > ?", 1.day.ago)
      end
      @scope = query.to_a
    end

    def fill_hash_for_attribute(attr)
      {}.tap do |h|
        scope.each do |snapshot|
          h[snapshot.created_at] = snapshot.send(attr)
        end
      end
    end
  end
end