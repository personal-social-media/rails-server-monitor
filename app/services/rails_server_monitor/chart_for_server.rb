# frozen_string_literal: true

module RailsServerMonitor
  class ChartForServer
    AVAILABLE_TIMELINES = %w(today week month all)
    attr_reader :server, :timeline
    def initialize(server, timeline:)
      @server = server
      @timeline = timeline.blank? ? "today" : timeline
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
      timeline == "today"
    end

    def last_record
      @last_record = scope.last
    end

    def scope
      return @scope if defined? @scope
      query = server.server_snapshots.order(id: :asc)
      if today?
        query = query.where("created_at > ?", 1.day.ago)
      elsif timeline == "week"
        query = query.where("created_at > ?", 7.day.ago)
      elsif timeline == "month"
        query = query.where("created_at > ?", 30.day.ago)
      else
        query = query.all
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
