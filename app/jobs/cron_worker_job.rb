class CronWorkerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Manoj is running with args: #{args}"
  end
end
