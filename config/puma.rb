# Redirect STDOUT / STDERR to physical log location
# stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true

# threads min, max
# Configure "min" to be the minimum number of threads to use to answer
# requests and "max" the maximum.
# The default is "0, 16".
threads 1, ENV.fetch('PUMA_MAX_THREADS', 5).to_i

# Specifies the `port` that Puma will listen on to receive requests, default is 3000.
port ENV.fetch('PORT', 3000).to_i

# Specifies the `environment` that Puma will run in.
environment ENV.fetch('RAILS_ENV', 'development')

# workers
# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked webserver processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
workers ENV.fetch('PUMA_WORKERS', 2).to_i

# worker_timeout
# Verifies that all workers have checked in to the master process within
# the given timeout. If not the worker process will be restarted. This is
# not a request timeout, it is to protect against a hung or dead process.
# Setting this value will not protect against slow requests.
# Default value is 60 seconds.
worker_timeout ENV.fetch('PUMA_WORKER_TIMEOUT', 120).to_i

# Change the default worker timeout for booting
# If unspecified, this defaults to the value of worker_timeout.
worker_boot_timeout 180

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory. If you use this option
# you need to make sure to reconnect any threads in the `on_worker_boot`
# block.
preload_app!

# The code in the `on_worker_boot` will be called if you are using
# clustered mode by specifying a number of `workers`. After each worker
# process is booted this block will be run, if you are using `preload_app!`
# option you will want to use this block to reconnect to any threads
# or connections that may have been created at application boot, Ruby
# cannot share connections between processes.
on_worker_boot do
  ActiveRecord::Base.establish_connection if defined?(ActiveRecord)
end
