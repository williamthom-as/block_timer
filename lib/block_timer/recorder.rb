# frozen_string_literal: true

module BlockTimer

  class Recorder

    # @param [String] name
    # @param [Printer] printer
    # @param [Proc] block
    # @return [Hash<Symbol, Time>]
    def self.time(
      name: "Timer",
      printer: Printer.new,
      &block
    )
      raise "Block must be provided!" unless block

      recorder = Recorder.new(name: name, printer: printer)
      recorder.start

      yield recorder

      recorder.stop
      recorder.print

      recorder.times
    end

    attr_reader :name, :printer, :times

    # @param [String] name
    # @param [Printer] printer
    def initialize(
      name: "Timer",
      printer: Printer.new
    )
      @name = name
      @printer = printer
      @times = {}
    end

    # @return void
    def start
      return if @times.key? :start_time

      @times[:start_time] = Time.now
    end

    # @param [Symbol, nil] identifier
    # @return void
    def lap(identifier: nil)
      identifier ||= "section_#{@times.keys.count - 1}".to_sym

      @times[identifier] = Time.now
    end

    # @return void
    def stop
      return if @times.key? :end_time

      @times[:end_time] = Time.now
    end

    # @return void
    def print
      @printer.call(name: @name, times: @times)
    end

  end

end
