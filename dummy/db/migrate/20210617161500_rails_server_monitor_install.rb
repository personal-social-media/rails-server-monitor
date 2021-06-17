class RailsServerMonitorInstall < ActiveRecord::Migration[6.1]
  def change
    create_table :rails_server_monitor_servers do |t|
      t.string :hostname
      t.datetime :last_seen_at
      t.string :custom_name
      t.text :custom_description
      t.text :system_information
      t.timestamps
    end

    create_table :rails_server_monitor_server_snapshots do |t|
      t.float :cpu_usage_percentage
      t.float :ram_usage_percentage
      t.float :hdd_usage_percentage
      t.text :ram_stats
      t.text :hdd_stats
      t.text :network_stats
      t.references :rails_server_monitor_server, null: false, foreign_key: true, index: { name: "rails_server_monitor_snapshots_on_server"}
    end
  end
end