Que.mode = :off
Que.worker_count = 1
Que.wake_interval = 5.0
Que.logger = Logger.new(STDOUT)

Que.log_formatter = proc do |data|
  # exclude :job_unavailable which creates a lot of chatter
  if [:job_unavailable].exclude?(data[:event])
    JSON.dump(data)
  end
end

# Que.error_notifier = proc do |error, job|
#   Raven.capture { raise error }
# end
