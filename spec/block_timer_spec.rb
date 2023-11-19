# frozen_string_literal: true

require "logger"

RSpec.describe BlockTimer do
  it "will print timer to terminal" do
    logger = instance_double(Logger)
    allow(logger).to receive(:info)

    response = BlockTimer.time(
      printer: BlockTimer::Printer.new(
        logger: logger
      )
    ) do |recorder|
      sleep(0.2)

      1.upto(3) do |_x|
        recorder.lap

        sleep(0.2)
      end
    end

    expect(logger).to have_received(:info).exactly(6).times
    expect(response.keys).to eq(
      [:start_time, :section_0, :section_1, :section_2, :end_time]
    )
  end
end
