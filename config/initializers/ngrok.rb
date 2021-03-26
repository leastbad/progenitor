# frozen_string_literal: true

if Rails.env.development?
  begin
    require "ngrok/tunnel"
    options = {addr: ENV["PORT"]}
    if File.file? ".ngrok"
      options[:config] = ".ngrok"
    elsif File.file? ENV["HOME"] + "/.ngrok"
      options[:config] = ENV["HOME"] + "/.ngrok"
    end
    if ENV["NGROK_INSPECT"]
      options[:inspect] = ENV["NGROK_INSPECT"]
    end
    if ENV["NGROK_SUBDOMAIN"]
      options[:subdomain] = ENV["NGROK_SUBDOMAIN"]
    end
    puts "[NGROK] tunneling at " + Ngrok::Tunnel.start(options)
    unless ENV["NGROK_INSPECT"] == "false"
      puts "[NGROK] inspector web interface listening at http://localhost:4040"
    end
  rescue
    puts "[NGROK] skipped: Go to ngrok.com to install if you dare"
  end
end