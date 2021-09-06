require "benchmark"
require "byebug/core"
require "byebug/attacher"

require "mole/column"
require "mole/config"
require "mole/control_flow"
require "mole/frame"
require "mole/path_classifier"
require "mole/path_filter"
require "mole/reflection"
require "mole/repl_processor"
require "mole/row"
require "mole/screen_manager"
require "mole/screen"
require "mole/screens"
require "mole/session"
require "mole/span"
require "mole/thread_info"
# require "mole/version"

module Mole
  class Error < StandardError; end

  def self.benchmark(name)
    return yield if ENV['MOLE_BENCHMARK'].nil?

    return_value = nil
    time = Benchmark.realtime { return_value = yield }

    File.open('./mole_benchmark.txt', 'a') do |f|
      f.puts "Benchmark `#{name}`: #{time}"
    end

    return_value
  end

  def self.debug(*info)
    File.open('./mole_debugs.txt', 'a') do |f|
      info.each do |line|
        f.puts line
      end
    end
  end

  def self.error(exception)
    File.open('./mole_errors.txt', 'a') do |f|
      f.puts '--- Error ---'
      f.puts exception.message
      f.puts exception.backtrace
    end
  rescue StandardError
    # Ignore
  end

  def self.config
    @config ||= Mole::Config.smart_load
  end

  def self.all_files
    Dir.glob(File.join(File.expand_path(__dir__, './lib'), '**', '*.rb')) +
      Dir.glob(File.join(File.expand_path(__dir__, './lib'), '*.rb')) +
      Dir.glob(File.join(File.expand_path(__dir__, './bin'), '**', '*.rb')) +
      Dir.glob(File.join(File.expand_path(__dir__, './bin'), '*.rb'))
  end
end

module Kernel
  def mole
    Mole::Session.attach(caller_locations[0])
  end
end