#!/usr/bin/env ruby

unless defined?(Rails)
  exec("rails", "runner", __FILE__, *ARGV)
end

require 'highline/import'

username = ask("Username: ")
password = ask("Password: ") {|q| q.echo = false}
if ask("Create user? y or not: ") =~ /^y(?:es)?/
  User.create_user(username, password)
end
