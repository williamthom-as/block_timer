# frozen_string_literal: true

RSpec.describe BlockTimer::Recorder do
  it "print timer" do

    response = BlockTimer::Recorder.time do |recorder|
      sleep(1)

      1.upto(3) do |_x|
        recorder.lap

        sleep(1)
      end
    end

    expect(response.class).to eq(Hash)
  end
end
