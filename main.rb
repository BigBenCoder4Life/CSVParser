=begin
Purpose: This Program opens a CSV file and stores the data
@author: Ben Kirtley
This work complies with the James Madison University Honor Code.
=end
require "csv"

def parse_csv_file(delim, file_name) 
    
  index = 0                          #Index of array
  temp_array  = Array.new            #Create an array
  file  = File.open(file_name, "r")  #Open a file for reading
  
  #Iterate file, parse strings and store
  CSV.foreach(file_name, { :col_sep => delim }) do |row|
  temp_array[index] = row.compact
  index +=1
  end
  
  #Close resource
  file.close
  
  return temp_array
end

@@stored_array = parse_csv_file(",", "file.csv") 

puts @@stored_array.inspect
