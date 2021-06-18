# frozen_string_literal: true

module RailsServerMonitor
  class HomeController < ApplicationController
    def index
      @title = "Home"
    end
  end
end
