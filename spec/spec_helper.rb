$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'big-door'
require 'rspec'
# optionally add autorun support
require 'rspec/autorun'

Rspec.configure do |c|

end
