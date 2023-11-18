# frozen_string_literal: true

module BlockTimer
  class Printer

    # @param [Logger] logger
    # @param [BlockTimer::Transformer] transformer
    # @param [Integer] round_by
    def initialize(
      logger: Logger.new($stdout),
      transformer: Transformer.new,
      round_by: 4
    )
      @logger = logger
      @transformer = transformer
      @round_by = round_by
    end

    def call(name:, times:)
      trans = @transformer.call(times: times)

      @logger.info {
        "[#{name}] total time taken: #{(trans[:end_time][:time] - trans[:start_time][:time]).round(@round_by)}"
      }

      trans.each do |k, result|
        @logger.info {
          "\t[#{k}]: #{result[:time].strftime("%H:%M:%S")} " \
            "(#{result[:time_between].round(@round_by)} seconds between, " \
            "#{result[:time_since_start].round(@round_by)} since start)"
        }
      end
    end
  end
end
