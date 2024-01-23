#!/usr/bin/env falcon --verbose serve -c
# frozen_string_literal: true

# Save this as `config.ru`, make it executable and then run it (or run falcon serve by hand)

# Middleware that responds to incoming requests:
require 'sinatra/base'
require 'fiber_pool'
require 'sequel'

Sequel.extension :fiber_concurrency

# Either use this or the pool below
$sequel = Sequel.connect(adapter: "postgres", database: "postgres", max_connections: 20)

$pool = FiberPool::Pool.new(20) do
  conn = Sequel.connect(adapter: "postgres", database: "postgres", max_connections: 1) # Keep it to 1 to make sure we use FiberPool instead of Sequel's connection pool.
end

class MyApp < Sinatra::Base
	get "/" do
    # $sequel.fetch("SELECT pg_sleep(1)").first
    # OR
    $pool.with_connection do |conn|
      conn.fetch("SELECT pg_sleep(1)").first
    end
		[200, {}, ["Hello, world!"]]
	end
end

# Build the middleware stack:
use MyApp # Then, it will get to Sinatra.
run lambda {|env| [404, {}, []]} # Bottom of the stack, give 404.
