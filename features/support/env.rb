$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'big-door'
require 'ruby-debug'
require 'spec/expectations'
require 'vcr'

VCR.config do |c|
  c.cassette_library_dir = 'vcr_cassettes'
  c.http_stubbing_library = :fakeweb
  c.default_cassette_options = { :record => :none }
end
