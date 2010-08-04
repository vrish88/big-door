require 'httparty'
require 'json'
require 'uri'
require 'cgi'

module BigDoor
	BASE_URL = 'http://api.bigdoor.com'.freeze
	BASE_URI = 'api/publisher'.freeze
end

directory = File.expand_path(File.dirname(__FILE__))

require File.join(directory, "big-door", "base")
require File.join(directory, "big-door", "request")