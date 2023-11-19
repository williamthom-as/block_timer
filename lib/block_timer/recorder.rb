# frozen_string_literal: true

module BlockTimer

  class Recorder

    attr_reader :times

    def initialize
      @times = {}
    end

    # @return void
    def start
      raise InvalidOperationError, "Stopwatch has already started" if @times.key? :start_time

      @times[:start_time] = Time.now
    end

    # @param [Symbol, nil] identifier
    # @return void
    def lap(identifier: nil)
      validate_running

      identifier ||= "section_#{@times.keys.count - 1}".to_sym
      @times[identifier] = Time.now
    end

    # @return void
    def stop
      validate_running

      @times[:end_time] = Time.now
    end

    private

    # @raises [InvalidOperationError]
    # @return [void]
    def validate_running
      raise InvalidOperationError, "Stopwatch has not been started" unless @times.key?(:start_time)
      raise InvalidOperationError, "Stopwatch has ended already" if @times.key?(:end_time)
    end
  end
end
