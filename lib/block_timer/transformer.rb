# frozen_string_literal: true

module BlockTimer

  class Transformer

    # @param [Hash<Symbol, Time>] times
    # @return [Hash]
    def call(times:)
      last_time = nil
      start_time = times[:start_time]

      times.sort_by { |_, v| v }.to_h.each_with_object({}) do |(k, time), result|
        result[k] = {
          time: time,
          time_between: last_time.nil? ? 0.0 : (time - last_time),
          time_since_start: time - start_time
        }

        last_time = time
        start_time ||= time
      end
    end
  end
end
