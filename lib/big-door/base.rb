module BigDoor
	class Base
		
		def initialize(*args)
			options = args.last
			@app_key = options[:app_key]
			@secret_key = options[:secret_key]
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
			super if name.nil? or request_type.nil? or method_name.nil?
			send("perform_#{request_type}", method_name, args)
		end
		private
			def perform_get(path, query={})
				# debugger
				query = {} if query.is_a? Array and query.empty?
				path = [BASE_URI, @app_key, path].join('/')
				query[:time] = "%.2f" % Time.now.to_f
				query[:sig] = calculate_sha2_hash(path, query)
				query[:format] = 'json'
				url = [BASE_URL, path].join('/') + '?' + to_url_params(query)
				# puts url
				BigDoor::Request.get(url)
			end
			
			def calculate_sha2_hash(path, query)
				path = '/' + path
				Digest::SHA2.new(bitlen = 256).update(path + concat_query(query) + @secret_key).to_s
			end
			
			def concat_query(query)
				str = ''
				query.keys.sort.each do |key|
					str << key.to_s + query[key].to_s unless [:sig, :format].include?(key)
				end
				str
			end
			
			def to_url_params(hash)
				elements = []
				hash.each_pair do |key, val|
					elements << "#{CGI::escape(key.to_s)}=#{CGI::escape(val.to_s)}"
				end
				elements.join('&')
			end
	end
end
