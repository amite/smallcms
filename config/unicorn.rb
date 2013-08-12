APP_ROOT =  File.expand_path("../..", __FILE__)

working_directory APP_ROOT
pid "#{APP_ROOT}/tmp/unicorn.pid"
worker_processes 2

preload_app true

listen "/tmp/unicorn.sock"
timeout 30

stdout_path "/vagrant/log/unicorn.log"
stderr_path "/vagrant/log/unicorn.log"

old_pid = APP_ROOT + '/tmp/unicorn.pid'
if File.exists?(old_pid)
  puts "Found existing unicorn PID"
  begin
    pid = File.read(old_pid).to_i
    File.delete(old_pid)
    Process.kill("QUIT", pid)
    puts "shut down previous unicorn (#{pid})"
  rescue Errno::ENOENT, Errno::ESRCH
    puts "was already dead"
  end
end
puts "unicorn started"
before_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
end
 
after_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end