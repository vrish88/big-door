# [{"sent_good_summaries"=>[], "level_summaries"=>[], "read_only"=>0, "received_good_summaries"=>[], "guid"=>"a24ff58ca0d711df966120ad2f73afad", "created_timestamp"=>1281043384, "modified_timestamp"=>1281043384, "end_user_login"=>"testers", "award_summaries"=>[], "currency_balances"=>[], "resource_name"=>"end_user"}, {}]

module BigDoor
	class User
		def initialize(params)
			params.each_pair do |key, val|
				self.class.class_eval do
					next if self.instance_methods.include?(key)
					self.instance_eval do
						attr_accessor key
					end
				end
				instance_variable_set("@#{key}", val)
			end
		end
		
		def all
			perform_request('get', 'end_user')
		end
	end
end
