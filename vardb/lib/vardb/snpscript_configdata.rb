module ConfigData
	
	def set_connection(connection_hash)
    	host = { 
      	:host => "#{connection_hash[:host]}", 
  	  	:port => "#{connection_hash[:port]}", 
  	  	:dbname => "#{connection_hash[:dbname]}", 
  	  	:user => "#{connection_hash[:user]}", 
  	  	:password => "#{connection_hash[:password]}",  
  		}
  	end

  	def set_metadata(file)
  		metadata_file = file
  	end

  	def set_matrix(file)
  		matrix_file = file
    end

end