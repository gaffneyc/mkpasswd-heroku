require "bundler/setup"

require "sinatra/base"
require "securerandom"
require "rack/ssl"

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

  set :root, File.expand_path("..", __FILE__)
  set :public_folder, "public"

  get "/" do
    File.read(File.expand_path("../public/index.html", __FILE__))
  end

  post "/" do
    password = params[:password]
    password.crypt("$6$#{SaltGenerator.generate}$")
  end
end
