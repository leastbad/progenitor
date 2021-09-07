# frozen_string_literal: true

module Mole
  class Config
    class << self
      def smart_load
        config = Mole::Config.new

        unless ENV["MOLE_CONFIG_FILE"].nil?
          unless File.exist?(ENV["MOLE_CONFIG_FILE"])
            raise "Config file '#{ENV["MOLE_CONFIG_FILE"]}' does not exist"
          end

          return load_config(config, ENV["MOLE_CONFIG_FILE"])
        end

        path = File.expand_path(File.join(Dir.pwd, CONFIG_FILE_NAME))
        load_config(config, path) if File.exist?(path)

        path = File.expand_path(File.join("~/", CONFIG_FILE_NAME))
        load_config(config, path) if File.exist?(path)

        config
      end

      private

      def load_config(config, path)
        config_content = File.read(path)
        config.instance_eval(config_content)

        config
      rescue SyntaxError, StandardError => e
        raise "Fail to load Mole configurations at #{path}. Error: #{e}"
      end
    end

    attr_accessor :color_scheme
    attr_reader :filter_version, :filter, :filter_included, :filter_excluded

    CONFIG_FILE_NAME = ".molerc"
    DEFAULTS = [
      DEFAULT_COLOR_SCHEME = "deep-space",
      DEFAULT_FILTER = Mole::PathFilter::FILTER_APPLICATION,
      DEFAULT_FILTER_INCLUDED = [].freeze,
      DEFAULT_FILTER_EXCLUDED = [].freeze
    ].freeze

    def initialize
      @filter_version = 0

      @filter = DEFAULT_FILTER
      @filter_included = DEFAULT_FILTER_INCLUDED.dup.freeze
      @filter_excluded = DEFAULT_FILTER_EXCLUDED.dup.freeze
    end

    def config
      self
    end

    def filter=(input)
      @filter_version += 1
      @filter = input.freeze
    end

    def filter_excluded=(input)
      @filter_version += 1
      @filter_excluded = input.freeze
    end

    def filter_included=(input)
      @filter_version += 1
      @filter_included = input.freeze
    end
  end
end
