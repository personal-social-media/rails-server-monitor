# frozen_string_literal: true

RailsServerMonitor::Engine.routes.draw do
  root to: "home#index"

  resources :servers, only: %i(show update)
  resources :snapshots, only: :show
end
