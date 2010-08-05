require 'httparty'
require 'json'
require 'uri'
require 'cgi'
require 'uuidtools'

module BigDoor
	BASE_URL = 'http://api.bigdoor.com'.freeze
	BASE_URI = 'api/publisher'.freeze
	
	class BigDoorError < StandardError; end
end

directory = File.expand_path(File.dirname(__FILE__))

require File.join(directory, "big-door", "base")
require File.join(directory, "big-door", "request")
require File.join(directory, "big-door", "user")
