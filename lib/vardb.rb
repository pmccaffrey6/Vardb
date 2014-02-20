require 'vardb/snp_db_build'
require 'vardb/database_populator'
require 'vardb/snpscript_configdata'
require 'vardb/test_association'

class Vardb
	include Builder
	include Populator
	include ConfigData
	include TestAssociation
end