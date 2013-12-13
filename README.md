[![Gem Version](https://badge.fury.io/rb/vardb.png)](http://badge.fury.io/rb/vardb)

#Vardb

##Introduction
This gem exists to create PostgreSQL databases from .matrix files and associated metadata spreadsheets. This gem will create a metadata table based upon the column headers in the given excel file. However, there are some simple best practices to consider when making your Excel spreadsheet: 

1. Every column should have a header
2. Each row should have some data in the first column, it's ok to have blanks after that 
3. There shouldn't be duplicate column names
4. It's best to avoid characters like "(", ")", "-" and whitespace in column names 
5. The gem loads the first sheet only so if you have a workbook of sheets they need to be broken out into separate .xls files or merged into one table.

##Installation:
```ruby
gem install vardb
```

##Usage:
##1. Database Construction
###Give Vardb your Database connection details
```ruby
db = Vardb.new
```

```ruby
db.set_connection(:host => '', :port => '', :dbname => '', :user => '', :password => '')
```
                     
###Tell Vardb what .matrix file you want to load
```ruby
db.set_matrix('/Users/username/file.matrix')
```        

###Tell Vardb what Excel spreadsheet you want to load
```ruby
db.set_metadata('/Users/username/metadata.xls')
```                                          

###Build a Schema from the .matrix file
```ruby
db.format_matrix
```                     

###Populate the database form your .matrix file                     
```ruby
db.populate_matrix
```

###Build a Schema from your spreadsheet
```ruby
db.format_metadata
```
                     
###Populate the database from your spreadsheet
```ruby
db.populate_metadata
```

##….And that's all!
###Now you have a PostgreSQL database from your files

##2. Analysis (this is in early development)
###Test your database for snp/phenotype associations
The ```ruby test_association ``` method accepts 4 parameters:
1. snps []: an array of snps
2. phenotype: hash where the keys and values represent phenotypes. These are determined by the columns anv values in your metadata spreadsheet. Say you have a column called "penicillinresistance" and the values in that column's cells were things like "susceptible" or "resistant". An appropriate phenotype hash to test for an association would therefore be ```ruby :penicillinresistance => 'resistant' ```
3. minimum support: this is the minimum cutoff for the frequeny of the association amongst the whole pool of samples
4. minimum confidence: this is the minimum cutoff for the confidence of the relationship

```ruby
db.test_association([1, 2, 5674, 272, 98790], {:penicillinresistance => 'resistant'}, 0.4, 0.5)
```

