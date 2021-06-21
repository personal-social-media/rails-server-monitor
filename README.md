# Rails Server Monitor
A performance dashboard for rails applications which work with one or multiple servers at once.
Stats can be collected from a Rack application or Sidekiq.

[See it in action](https://rails-sever-monitor.herokuapp.com)

![demo](https://github.com/personal-social-media/rails-server-monitor/raw/master/resources/screenshot-dashboard.jpg)
![demo](https://github.com/personal-social-media/rails-server-monitor/raw/master/resources/screenshot1.jpg)

## Usage
#### 1)
```ruby
gem 'rails-server-monitor', require: "rails_server_monitor"
```

#### 2) generate Rails Server Monitor tables
```bash
rails g rails_server_monitor:install
rails db:migrate
```

#### 3) hook Rails Server Monitor's rack middleware
```ruby
# inside config/application.rb
config.middleware.use RailsServerMonitor::RackMiddleware
```

#### 4) compile Rails Server Monitor assets locally
if you aren't using webpacker already
```shell
# you don't need to do this in production, it's prepended to rake assets:precompile
# but you need to do it again after you after you update the gem locally
rake webpacker:compile 
```

or if you are using

```ruby
# inside bin/webpack-dev-server
require "rails_server_monitor/compile_locally"
RailsServerMonitor::CompileLocally.compile 

# insert before this before
# Dir.chdir(APP_ROOT) do
#   Webpacker::DevServerRunner.run(ARGV)
# end
```

#### 5) (Optional) configure gem

```ruby
# inside config/initializers/rails_server_monitor

RailsServerMonitor.config do |c|
  c.update_server_interval = 1.hour 
  c.snapshot_server_interval = 15.minutes
  c.cleanup_snapshots_after = 90.days
  c.ignore_workers = %w(MyIgnoredWorker)
  c.ignore_urls = ["/", /ignored-url/]
  
  c.high_cpu_usage_threshold = 95
  c.low_memory_threshold = 20
  c.low_free_disk_disk_threshold = 30
  c.hostname = -> do
    `hostname`
  end # how to retrieve server hostname, heroku generates a hostname each time your app reboots
end
```

#### 6) Mount engine to routes

```ruby
# inside config/routes.rb
constraints LoggedInAsAdmin do
  mount RailsServerMonitor::Engine => "/system-information"
end
```

Your should define a constraint to protect against unauthorized access

```ruby
# example LoggedInAsAdmin, this is a basic implementation

class LoggedInAsAdmin
  def self.matches?(request)
    AdminUser.find_by(id: request.session[:admin_id]).present?
  end
end


```

#### 7) (Optional) Add sidekiq middleware

```ruby
# append to config/sidekiq.rb

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add RailsServerMonitor::SidekiqMiddleware
  end
end
```

### 8) Result

you should now go to http://localhost:3000/system-information

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/personal-social-media/rails-server-monitor/issues)
- Fix bugs and [submit pull requests](https://github.com/personal-social-media/rails-server-monitor/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

### Development

```shell
# fork project, clone
bundle install
yarn install

bin/start # to start local server
bin/rspec # to run specs
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).