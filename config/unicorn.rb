APP_PATH = File.expand_path("../..", __FILE__)
working_directory APP_PATH

worker_processes 3
# listen 3000
listen "/tmp/unicorn.sock"
timeout 30
pid "/tmp/unicorn.smallcms.pid"

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  # Before forking, kill the master process that belongs to the .oldbin PID.
  # This enables 0 downtime deploys.
  old_pid = "/tmp/unicorn.smallcms.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

stderr_path APP_PATH + "/log/unicorn.smallcms.stderr.log"
stdout_path APP_PATH + "/log/unicorn.smallcms.stdout.log"