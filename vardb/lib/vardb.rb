require 'vardb/snp_db_build'
require 'vardb/database_populator'
require 'vardb/snpscript_configdata'

class Vardb
	include Builder
	include Populator
	include ConfigData

	def self.set_connection(connection_hash)
		ConfigData.set_connection(connection_hash)
	end

	def self.set_metadata(file)
		ConfigData.set_metadata
	end

	def self.set_matrix(file)
		ConfigData.set_matrix
	end

	def self.format
		Builder.format_database
	end

	def self.populate
		Populator.populate_database
	end
end