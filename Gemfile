source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

gem "rails", "~> 6.1.3.1"
gem "pg", "~> 1.1"
gem "puma", "~> 5.2.1"
gem "webpacker", "~> 5.4.0"
gem "turbolinks", "~> 5.2"
gem "jbuilder", "~> 2.7"
gem "redis", ">= 4.0", require: ["redis", "redis/connection/hiredis"]
gem "hiredis"
gem "redis-session-store", "~> 0.11.3"
# gem 'bcrypt', '~> 3.1.7'
gem 'image_processing', '~> 1.2'

gem "bootsnap", ">= 1.4.4", require: false

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "web-console", ">= 4.1.0"
  # gem 'rack-mini-profiler', '~> 2.0'
  gem "listen", "~> 3.3"
  gem "pry-rails"
  gem "ngrok-tunnel", "~> 2.1"
  gem "letter_opener", "~> 1.7"
  gem "standard", "~> 1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "webdrivers"
end

# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "devise", "~> 4.7"
# gem "cable_ready", "~> 4.5.0"
gem "cable_ready", github: "stimulusreflex/cable_ready", branch: "master"
# gem "stimulus_reflex", "~> 3.4.1"
gem "stimulus_reflex", github: "stimulusreflex/stimulus_reflex", branch: "master"
gem "optimism", "~> 0.4.1"
gem "sidekiq", "~> 6.1"
gem "sidekiq-scheduler", "~> 3.0"
gem "rqrcode", "~> 2.0"
gem "pagy", "~> 3.10.0"
gem "faker", "~> 2.16"
gem "devise_masquerade", "~> 1.3"
gem "kredis", "~> 0.2.3"
gem "chrono_trigger", "~> 1.0"
gem "pg_search", "~> 2.3"
gem "all_futures", github: "leastbad/all_futures", branch: "master"
gem "rorvswild"