# frozen_string_literal: true

module RailsServerMonitor
  class ServersController < ApplicationController
    before_action :require_current_server, only: %i(show update)

    def show
      @server = current_server
      @chart = RailsServerMonitor::ChartForServer.new(@server)

      @title = @server.display_name
    end

    def current_server
      @current_server ||= RailsServerMonitor::Server.find_by(id: params[:id])
    end

    def require_current_server
      redirect_to root_path, notice: "Server not found" if current_server.blank?
    end
  end
end
