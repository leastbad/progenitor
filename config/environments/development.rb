Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  config.session_store :redis_session_store, {
    key: "progenitor_session_",
    serializer: :json,
    redis: {
      driver: :hiredis,
      expire_after: 1.year,
      ttl: 1.year,
      key_prefix: "progenitor:session:",
      url: ENV.fetch("REDIS_URL") { "redis://localhost:6379/1" }
    }
  }

  config.hosts << /[a-z0-9]+\.ngrok\.io/

  config.log_level = :warn

  config.action_mailer.default_url_options = {host: "localhost", port: 3000}
  config.action_mailer.delivery_method = :letter_opener_web

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  config.action_controller.perform_caching = true
  config.action_controller.enable_fragment_cache_logging = true
  config.action_controller.default_url_options = {host: "localhost", port: 3000}

  config.cache_store = :redis_cache_store, {driver: :hiredis, url: ENV.fetch("REDIS_URL") { "redis://localhost:6379/1" }}
  config.public_file_server.headers = {
    'Cache-Control' => "public, max-age=#{2.days.to_i}"
  }

  # Store uploaded files on the local file system (see config/storage.yml for options).
  # config.active_storage.service = :local

  # Don't care if the mailer can't send.
  # config.action_mailer.raise_delivery_errors = false

  # config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true


  # Raises error for missing translations.
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
