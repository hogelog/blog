#!/usr/bin/env ruby

unless defined?(Rails)
  exec("rails", "runner", __FILE__, *ARGV)
end

require 'highline/import'

username = ask("Username: ")
if ask("Create user? y or not: ") =~ /^y(?:es)?/
  User.create(username: username)
end
