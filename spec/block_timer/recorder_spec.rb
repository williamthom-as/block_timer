# frozen_string_literal: true

module BlockTimer
  RSpec.describe Recorder do
    it "times appropriately and accurately" do
      recorder = Recorder.new

      start_time = Time.now
      recorder.start

      sleep(2)
      lap_time = Time.now
      recorder.lap

      sleep(2)
      end_time = Time.now
      recorder.stop

      times = recorder.times

      expect(start_time).to be_within(0.001).of(times[:start_time])
      expect(lap_time).to be_within(0.001).of(times[:section_0])
      expect(end_time).to be_within(0.001).of(times[:end_time])
    end

    it "times doesn't let you start twice" do
      recorder = Recorder.new
      expect {
        recorder.start
        recorder.start
      }.to raise_error(InvalidOperationError, "Stopwatch has already started")
    end

    it "times doesn't let you stop twice" do
      recorder = Recorder.new

      expect {
        recorder.start
        recorder.stop
        recorder.stop
      }.to raise_error(InvalidOperationError, "Stopwatch has ended already")
    end

    it "doesn't let you stop if its not started" do
      recorder = Recorder.new
      expect {
        recorder.stop
      }.to raise_error(InvalidOperationError, "Stopwatch has not been started")
    end

  end
end
