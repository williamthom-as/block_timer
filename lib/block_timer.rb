# frozen_string_literal: true

require "block_timer/version"
require "block_timer/recorder"
require "block_timer/transformer"
require "block_timer/printer"

module BlockTimer

  class InvalidOperationError < StandardError; end

  def self.time(
    name: "Timer",
    printer: Printer.new,
    recorder: Recorder.new,
    &block
  )
    raise "Block must be provided!" unless block

    recorder.start

    yield recorder

    recorder.stop

    printer.call(name: name, times: recorder.times)

    recorder.times
  end
end
