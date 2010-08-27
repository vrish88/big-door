module BigDoor
	class Base
		include ClassMethods
		
		def initialize(*args)
			options = args.last
			ClassMethods.module_eval do
				instance_variable_set('@app_key', options[:app_key])
			end
			ClassMethods.module_eval do
				instance_variable_set('@secret_key', options[:secret_key])
			end
		end
		
		# def get_award_summary
		# 	perform_get('award_summary')
		# end
		# 
		# def get_transaction_summary
		# 	perform_get('transaction_summary')
		# end
		# 
		# def get_level_summary
		# 	perform_get('level_summary')
		# end
		# 
		# def get_good_summary
		# 	perform_get('good_summary')
		# end
		# 
		# def get_currency_type
		# 	perform_get('currency_type')
		# end
		# 
		# def get_currency
		# 	perform_get('currency')
		# end

		def method_missing(name, *args)
			name, request_type, method_name = name.to_s.match(/(put|post|get|delete)_(.+)/).to_a
			super(name, args) if name.nil? or request_type.nil? or method_name.nil?
			perform_request request_type, method_name, args.first
		end
	end
end
