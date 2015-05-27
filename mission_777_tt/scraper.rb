# -*- coding: utf-8 -*-

# Author: Nesh108
# Date: 27/05/2015

require 'json'
require 'turbotlib'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

Turbotlib.log("Starting scraper for Central Bank of Trinidad and Tobago...") # optional debug logging

# index for JSON object
index = 0

# Dictionary for bank data
bank_data = Hash.new

# Fetching the page
source_url = 'http://www.central-bank.org.tt/content/banking-sector'
page = Nokogiri::HTML(open(source_url))

##########################################################################################
# Commercial Banks
# JSON object: {id: 0, type: 'Commercial Banks', name: 'name', url: 'example.com'}
comm_banks_type = page.css('div[class="field-item even"]').css('p')[3].text
comm_banks_type = comm_banks_type.slice(0..(comm_banks_type.index(' (') - 1))	# cleaning up

# Commercial Banks data
comm_banks_data = page.css('div[class="field-item even"]').css('p')[4].css('a')

for i in 0..(comm_banks_data.length - 1)
	bank_data["number"] = index
	bank_data["type"] = comm_banks_type
	bank_data["name"] = comm_banks_data[i].text
	bank_data["url"] = comm_banks_data[i]['href']
	bank_data["source_url"] = source_url
	bank_data["sample_date"] = Time.now
	puts bank_data.to_json
	index += 1	# increment index
end

##########################################################################################
# Non-Bank Financial Institutions
# JSON object: {id: 0, type: 'Non-Bank Financial Institutions', name: 'name', url: 'example.com'}
non_banks_type = page.css('div[class="field-item even"]').css('p')[5].text
non_banks_type = non_banks_type.slice(0..(non_banks_type.index(' (') - 1))

# Non-Bank Financial Institutions Banks data
non_banks_data = page.css('div[class="field-item even"]').css('p')[6].css('a')

for i in 0..(non_banks_data.length - 1)
	bank_data["number"] = index
	bank_data["type"] = non_banks_type
	bank_data["name"] = non_banks_data[i].text
	bank_data["url"] = non_banks_data[i]['href']
	bank_data["source_url"] = source_url
	bank_data["sample_date"] = Time.now
	puts bank_data.to_json
	index += 1	# increment index
end

##########################################################################################
# Title third part - Financial Holding Companies
# JSON object: {id: 0, type: 'Non-Bank Financial Institutions', name: 'name', url: 'example.com'}
fin_holds_type = page.css('div[class="field-item even"]').css('p')[8].text
fin_holds_type = fin_holds_type.slice(0..(fin_holds_type.index(' (') - 1))

# Financial Holding Companies data
fin_holds_data = page.css('div[class="field-item even"]').css('p')[9].text.split("<br>") 

for i in 0..(fin_holds_data.length - 1)
	bank_data["number"] = index
	bank_data["type"] = fin_holds_type
	bank_data["name"] = fin_holds_data[i]
	bank_data["url"] = 'null'
	bank_data["source_url"] = source_url
	bank_data["sample_date"] = Time.now
	puts bank_data.to_json
	index += 1	# increment index
end