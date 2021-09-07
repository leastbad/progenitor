# frozen_string_literal: true

module Mole
  class Session
    class << self
      def instance
        @instance ||= new
      end

      def attach(location)
        instance.start unless instance.started?
        return if instance.check_skip(location)

        Byebug.attach
        Byebug.current_context.step_out(3, true)
      end
    end

    attr_accessor :path_filter, :screen_manager #, :repl_manager

    def initialize
      @screen_manager = Mole::ScreenManager.new
      @path_filter = Mole::PathFilter.new
      @started = false
      @session_lock = Mutex.new

      sync(nil)
    end

    def start
      return if started?

      Byebug::Setting[:autolist] = false
      Byebug::Setting[:autoirb] = false
      Byebug::Setting[:autopry] = false

      Byebug::Context.processor = Mole::ReplProcessor
      Byebug::Context.ignored_files = Byebug::Context.all_files + Mole.all_files

      @screen_manager.start
      Mole.config
      at_exit { stop }
      @started = true
    end

    def stop
      return unless started?
      @screen_manager.stop
      Byebug.stop if Byebug.stoppable?
    end

    def started?
      @started == true
    end

    def should_stop?(path)
      @path_filter.match?(path)
    end

    def sync(context)
      @current_context = context
      # Remove cache
      @current_frame = nil
      @current_thread = nil
      @current_backtrace = nil
      @threads = nil
      @skip = 0
      @skipped_breakpoints = {}
    end

    def current_frame
      @current_frame ||=
        begin
          frame = Mole::Frame.new(@current_context, @current_context.frame.pos)
          frame.visible = @path_filter.match?(frame.frame_file)
          frame
        end
    end

    def current_thread
      @current_thread ||= Mole::ThreadInfo.new(@current_context.thread)
    end

    def current_backtrace
      @current_backtrace ||= generate_backtrace
    end

    def threads
      @threads ||=
        Thread
        .list
        .select(&:alive?)
        .reject { |t| t.name.to_s =~ /<<Mole:.*>>/ }
        .map { |t| Mole::ThreadInfo.new(t) }
    end

    def frame=(real_pos)
      @current_context.frame = @current_backtrace[real_pos].real_pos
      @current_frame = @current_backtrace[real_pos]
    end

    def step_into(times)
      @current_context.step_into(times, current_frame.real_pos)
    end

    def step_over(times)
      @current_context.step_over(times, current_frame.real_pos)
    end

    def lock
      raise Mole::Error, 'This method requires a block' unless block_given?

      # TODO: This doesn't solve anything. However, debugging a multi-threaded process is hard.
      # Let's deal with that later.
      @session_lock.synchronize do
        yield
      end
    end

    def skip(times)
      stop
      @skip = times
      @skipped_breakpoints = {}
    end

    def check_skip(location)
      location_str = "#{location.path}:#{location.lineno}"
      return true if @skipped_breakpoints[location_str]

      case @skip
      when 0
        false
      when -1
        true
      else
        @skip -= 1
        @skipped_breakpoints[location_str] = true
        true
      end
    end

    private

    def generate_backtrace
      virtual_pos = 0
      backtrace = @current_context.backtrace.map.with_index do |_frame, index|
        frame = Mole::Frame.new(@current_context, index)
        if @path_filter.match?(frame.frame_file)
          frame.visible = true
          frame.virtual_pos = virtual_pos
          virtual_pos += 1
        else
          frame.visible = false
        end
        frame
      end
      current_frame.virtual_pos = backtrace[current_frame.real_pos].virtual_pos
      backtrace
    end
  end
end