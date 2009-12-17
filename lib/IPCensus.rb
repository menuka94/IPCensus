require 'rubygems'
require 'geoip'
require 'fastercsv'

# Uses the GeoIP gem to look up a data entry about a certain IP or host.
#
#ip_path = '/data/ripd/GeoLiteCity.dat'
#
#ip_data = GeoIP.new(ip_path)
#
#print "Enter a host or IP address:"
#ip = gets.strip
#
#p ip_data.city(ip)

# Main data path
#data_path = '/data/ripd/GeoLiteCity_20091201/'

# Test data path
data_path = '/data/temp/minidata/'

ip_locations = data_path + 'GeoLiteCity-USLocation.csv'
ip_blocks = data_path + 'GeoLiteCity-Blocks.csv'

loc_hash = Hash.new(0)

FasterCSV.foreach(ip_locations) do |row|
  loc_hash[row[0]] = row[1..-1]
  p row
end

p loc_hash['1609']