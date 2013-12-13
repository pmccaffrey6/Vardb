require 'pg'

module TestAssociation
	def test_association(snp = [], phenotype = {}, min_support, min_confidence)
		host = ConfigData.get_connection

		conn = PGconn.connect(:host => host[:host], :port => host[:port], :dbname => host[:dbname], :user => host[:user], :password => host[:password])

		assoc_hash = {}

		total_samples = conn.exec("SELECT count(*) from samples").getvalue(0,0).to_f

		phenotype.each do |key, value|

			snp.each do |snp|
				## get the number of samples that have BOTH the snp AND the phenotype
				results = conn.exec("SELECT DISTINCT count(*) from samples s inner join samples_snps ss on (s.id = ss.sample_id) inner join sample_metadata smeta on (s.name = smeta.isolate) where ss.snp_id = #{snp} and smeta.#{key} = '#{value}'").getvalue(0,0).to_f
				## get the number of samples that have the snp in question
				samples_with_snp = conn.exec("SELECT count (*) from samples s inner join samples_snps ss on (s.id = ss.sample_id) where ss.snp_id = #{snp}").getvalue(0,0).to_f
			
				if results/total_samples > min_support then
					if results/samples_with_snp > min_confidence then
						assoc_hash[["#{snp}", "#{key}", "#{value}"]] = ["#{results/total_samples}", "#{results/samples_with_snp}"]
					end
				end
			end

		end

		puts assoc_hash
	end
end