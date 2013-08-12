APP_PATH = File.expand_path("../..", __FILE__)
working_directory APP_PATH

worker_processes 3
# listen 3000
listen "/tmp/unicorn.sock"
timeout 30
pid APP_PATH + "/tmp/pids/unicorn.pid"

stderr_path APP_PATH + "/log/unicorn.smallcms.stderr.log"
stdout_path APP_PATH + "/log/unicorn.smallcms.stdout.log"