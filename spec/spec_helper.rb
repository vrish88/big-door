$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'big-door'
require 'rspec'
require 'vcr'
require 'fakeweb'

# optionally add autorun support
require 'rspec/autorun'

Rspec.configure do |c|

end

VCR.config do |c|
  c.cassette_library_dir = 'vcr_cassettes'
  c.http_stubbing_library = :fakeweb
  c.default_cassette_options = { :record => :none }
end
