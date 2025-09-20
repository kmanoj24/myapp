class HardWorkerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Performing hard work with args: #{args}"
    # simulate a long-running task
    sleep 5
    puts "Job finished!"
  end
end
