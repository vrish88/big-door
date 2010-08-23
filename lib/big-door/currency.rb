module BigDoor
	class Currency
		include ClassMethods
		
		def initialize(params)
			params.each_pair do |key, val|
				self.class.class_eval do
					# overwrite the .id method and all others
					self.instance_eval do
						attr_accessor key
					end
				end
				instance_variable_set("@#{key}", val)
			end
		end
		
		def self.all
			perform_request('get', 'currency')
		end
		
		def self.find(params={})
			perform_request('get', 'currency', params)
		end
	end
end
