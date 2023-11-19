# frozen_string_literal: true

module BlockTimer
  class TestLogger

    attr_reader :messages

    def initialize
      @messages = []
    end

    def info(string = nil, &block)
      return @messages << string if string

      @messages << block.call
    end
  end

  RSpec.describe Printer do
    it "prints the correct messages" do
      start_time = Time.now
      end_time = Time.now + 60

      times = {
        start_time: start_time,
        end_time: end_time
      }

      logger = TestLogger.new
      printer = Printer.new(
        logger: logger,
        opts: {
          decimal_formatter: ->(d) { d.to_i }
        }
      )
      printer.call(name: "test", times: times)

      messages = logger.messages
      expect(messages.size).to eq(3)
      expect(messages[0]).to eq("[test] total time taken: 60")

      start_msg = "\t[start_time]: #{start_time.strftime("%H:%M:%S")} (0 seconds between, 0 since start)"
      expect(messages[1]).to eq(start_msg)

      stop_msg = "\t[end_time]: #{end_time.strftime("%H:%M:%S")} (60 seconds between, 60 since start)"
      expect(messages[2]).to eq(stop_msg)
    end

    it "uses the custom formatters" do
      start_time = Time.now
      end_time = Time.now + 60

      times = {
        start_time: start_time,
        end_time: end_time
      }

      date_format = "%Y-%m-%d %H:%M:%S"

      logger = TestLogger.new
      printer = Printer.new(
        logger: logger,
        opts: {
          decimal_formatter: ->(f) { f.round(1) },
          date_formatter: ->(d) { d.strftime(date_format) }
        }
      )

      printer.call(name: "test", times: times)

      start_msg = "\t[start_time]: #{start_time.strftime(date_format)} (0.0 seconds between, 0.0 since start)"
      expect(logger.messages[1]).to eq(start_msg)
    end
  end
end
