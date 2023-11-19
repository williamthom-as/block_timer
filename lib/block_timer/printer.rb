# frozen_string_literal: true

module BlockTimer
  class Printer

    # @param [Logger] logger
    # @param [BlockTimer::Transformer] transformer
    # @param [Hash] opts
    # @option [(Date)->String] :date_formatter - formatter for date
    # @option [(Float)->String] :decimal_formatter - formatter for numbers
    def initialize(
      logger: Logger.new($stdout),
      transformer: Transformer.new,
      opts: {}
    )
      @logger = logger
      @transformer = transformer
      @date_formatter = opts.fetch(:date_formatter, ->(f) { f.strftime("%H:%M:%S") })
      @decimal_formatter = opts.fetch(:decimal_formatter, ->(d) { d.round(4) })
    end

    def call(name:, times:)
      trans = @transformer.call(times: times)

      @logger.info {
        "[#{name}] total time taken: " \
          "#{@decimal_formatter.call((trans[:end_time][:time] - trans[:start_time][:time]))}"
      }

      trans.each do |k, result|
        @logger.info {
          "\t[#{k}]: #{@date_formatter.call(result[:time])} " \
            "(#{@decimal_formatter.call(result[:time_between])} seconds between, " \
            "#{@decimal_formatter.call(result[:time_since_start])} since start)"
        }
      end
    end
  end
end
