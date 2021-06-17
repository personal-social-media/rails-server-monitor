# frozen_string_literal: true

module RailsServerMonitor
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
