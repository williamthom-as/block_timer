# frozen_string_literal: true

module BlockTimer
  RSpec.describe Transformer do
    it "calculates the correct values" do
      start_time = Time.now
      times = {
        start_time: start_time,
        end_time: start_time
      }

      result = Transformer.new.call(times: times)

      expect(result[:start_time]).to eq({
        time: start_time,
        time_between: 0.0,
        time_since_start: 0.0
      })

      expect(result[:end_time]).to eq({
        time: start_time,
        time_between: 0.0,
        time_since_start: 0.0
      })
    end
  end
end
