APP_ROOT =  File.expand_path("../..", __FILE__)

working_directory APP_ROOT
pid "#{APP_ROOT}/tmp/pids/unicorn.pid"
worker_processes 2

listen "/tmp/unicorn.sock"
timeout 30