working_directory File.expand_path("../..", __FILE__)
worker_processes 3
listen "/tmp/unicorn.sock"
timeout 30
pid "/tmp/unicorn_smallcms.pid"