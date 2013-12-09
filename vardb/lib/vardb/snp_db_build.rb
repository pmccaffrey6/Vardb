require_relative 'xls_parser'
require 'pg'

module Builder
	include XlsParser
	def format
		host = ConfigData.get_connection

		metadata_fields = XlsParser.load_meta_fields(ConfigData.get_metadata)

		metadata_field_names = ""

		metadata_fields.each do |name|
			name << " varchar(128)"
			metadata_field_names << name
		end

		conn = PGconn.connect(:host => host[:host], :port => host[:port], :dbname => host[:dbname], :user => host[:user], :password => host[:password])

		puts "formatting annotations table..."
		conn.exec("CREATE TABLE annotations (id numeric(11) PRIMARY KEY, cds varchar(128), transcript varchar(128), transcript_id varchar(128), info text, orientation varchar(128), cds_locus varchar(128), codon_pos varchar(128), codon varchar(128), peptide varchar(128), amino_a varchar(128), syn varchar(128))")

		puts "formatting snps table..."
		conn.exec("CREATE TABLE snps (id numeric(11) PRIMARY KEY, locus numeric(11), annotation_id numeric(11))")

		puts "formatting samples table..."
		conn.exec("CREATE TABLE samples (id numeric(11) PRIMARY KEY, name varchar(128))")

		puts "formatting samples_snps join table..."
		conn.exec("CREATE TABLE samples_snps (sample_id numeric(11), snp_id numeric(11))")

		puts "formatting sample data table..."
		conn.exec("CREATE TABLE sample_metadata (id numeric (11) PRIMARY KEY#{metadata_field_names})")
	end
end