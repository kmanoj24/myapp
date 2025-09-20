require 'sidekiq'
require 'sidekiq-cron'

# Sidekiq::Cron::Job.load_from_hash!(
#   'cron_worker_job' => {
#     'class' => 'CronWorkerJob',
#     'cron'  => '*/2 * * * *', # every 2 minutes
#     'queue' => 'default'
#   }
# )
