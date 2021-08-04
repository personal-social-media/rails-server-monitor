# frozen_string_literal: true

namespace :assets do
  desc "Install rails-server-monitor deps with yarn"
  task :rails_server_monitor_yarn_install do
    Dir.chdir(File.join(__dir__, "..", "..")) do
      system "yarn install --no-progress --production"
    end
  end

  desc "Compile rails-server-monitor JavaScript packs using webpack for production with digests"
  task rails_server_monitor_compile: [:rails_server_monitor_yarn_install, :environment] do
    Webpacker.with_node_env("production") do
      if RailsServerMonitor.webpacker.commands.compile
        # Successful compilation!
      else
        # Failed compilation
        exit!
      end
    end
  end
end

Rake::Task["assets:precompile"].enhance do
  Rake::Task["assets:rails_server_monitor_compile"].invoke
end
