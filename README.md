# Rapidash Tester

This is a simple client/server example to test the [Rapidash gem](http://rapidashgem.com)

## Starting the server

Open up a terminal to run the server (the `blogsprout` dir)

`cd blogsprout && rails s`

## Starting the client

Open another terminal to run the client (the `blogsprout-client` dir)

`cd blogsprout-client && irb -I . -r client`

### Running the tests

`cd blogsprout-client && bundle exec rspec client.rb`

The tests here aim to be a real life example of the tests in rapidash.  This should also serve as a demo for implementing your own client.
