class DemoWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5, retry_intervals: [5, 5, 5, 5, 5], dead: true
  def perform(should_fail = false)
    if should_fail
      raise "Intentional failure for demo!"
    else
      Rails.logger.info "DemoWorker ran successfully!"
    end
  end
end