require 'digest'
class User < ActiveRecord::Base

  has_many :articles

  class InvalidUser < StandardError
  end

  def self.create_user(username, plain_password)
    encrypted_password = create_password(username, plain_password)
    User.create!(username: username,
                 password: encrypted_password)
  end

  def self.login_user(login_params)
    username = login_params[:username]
    plain_password = login_params[:password]
    user = User.where(username: username).first

    if !user || !check_valid_password(user, plain_password)
      message = 'Invalid username or password'
      Rails.logger.info(message)
      raise InvalidUser.new(message)
    end

    user
  end

  def self.check_valid_password(user, plain_password)
    encrypted_password = create_password(user.username, plain_password)
    user.password == encrypted_password
  end

  def self.create_password(username, plain_password)
    seed = '' <<
      Rails.configuration.secret_key_base <<
      username <<
      plain_password
    Digest::SHA512.hexdigest(seed)
  end
end
