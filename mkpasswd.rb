require "bundler/setup"

require "sinatra/base"
require "securerandom"
require "rack/ssl"
require "erubis"

class SaltGenerator
  VALID_SALT_CHARS = [
    ".", "/", (0..9).to_a, ("A".."Z").to_a, ("a".."z").to_a
  ].flatten.map(&:to_s)

  def self.generate
    16.times.map do |i|
      VALID_SALT_CHARS[SecureRandom.random_number(VALID_SALT_CHARS.size)]
    end.join
  end
end

class Mkpasswd < Sinatra::Base
  use Rack::SSL

  get "/" do
    erb :index
  end

  post "/" do
    salt = params[:password].crypt("$6$#{SaltGenerator.generate}$")
    erb :salt, :locals => { :salt => salt }
  end
end
