#!/usr/bin/env ruby

unless defined?(Rails)
  exec("rails", "runner", __FILE__, *ARGV)
end

require 'highline/import'

auth_provider = ask("auth_provider: ")
auth_uid = ask("auth_uid: ")
user_id = ask("user_id: ")
if ask("Create user? y or not: ") =~ /^y(?:es)?/
  GoogleAuthUser.create(user_id: user_id, provider: auth_provider, uid: auth_uid)
end
