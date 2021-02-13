# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
port        ENV.fetch("PORT") { 3000 }

# Specifies the `environment` that Puma will run in.
#
environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the `pidfile` that Puma will use.
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
# preload_app!

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

if ENV['RAILS_ENV'] == 'development' && `ngrok -v`.starts_with?("ngrok version")
  require 'ngrok/tunnel'
  options = {addr: ENV['PORT']}
  if File.file? '.ngrok'
    options[:config] = '.ngrok'
  elsif File.file? ENV['HOME'] + '/.ngrok'
    options[:config] = ENV['HOME'] + '/.ngrok'
  end
  if ENV['NGROK_INSPECT']
    options[:inspect] = ENV['NGROK_INSPECT']
  end
  if ENV['NGROK_SUBDOMAIN']
    options[:subdomain] = ENV['NGROK_SUBDOMAIN']
  end
  puts "[NGROK] tunneling at " + Ngrok::Tunnel.start(options)
  unless ENV['NGROK_INSPECT'] == 'false'
    puts "[NGROK] inspector web interface listening at http://localhost:4040"
  end
end