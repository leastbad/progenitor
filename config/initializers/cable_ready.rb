CableReady.configure do |config|
  # Enable/disable exiting / warning when the sanity checks fail options:
  # `:exit` or `:warn` or `:ignore`

  # Enable/disable exiting / warning when there's a new CableReady release
  # `:exit` or `:warn` or `:ignore`

  # config.on_new_version_available = :ignore

  config.add_operation_name :toast
end