=begin
Purpose: This Program opens a CSV file and stores the data
@author: Ben Kirtley
This work complies with the James Madison University Honor Code.
=end

=begin
     Purpose: Strips left and right side quotes and white spaces
  Parameters: token - The string to parse
     Returns: The striped string  
=end
def clean(token)
  token.lstrip!
  token.rstrip!
  if(token[0] == "\"")
    token[0] = ""
    token = token.chop! 
  end  
  return token
end

=begin
     Purpose: This Definition parses a line according to 
              a defined delimeter
  Parameters: delim - The delimeter to use in parsing
              line - The line to parse
     Returns: The parsed line in an array
  
=end
def parse_line(delim , line)
  temp_array = Array.new #Array to hold data
  index = 0              #Position of array index
  token = ""             #To hold the string
  grouping = false       #Grouping characters flag

  #Parse line with delimeter
  line.each_char do |char|
    #Grouping Block   
    if char == "\"" and !grouping
      token += char
      grouping = true
    elsif char == "\"" and grouping 
      token += char
      grouping = false
    elsif char == delim and !grouping 
      temp_array.push(clean(token)) 
      token = ""  
    else
      token += char
    end
  end 
  
  #Store last token on line
  temp_array.push(clean(token))
  
  return temp_array
end

=begin
     Purpose: This Definition parses a CSV file according
              to a defined delimeter
  Parameters: delim - The delimeter to use in parsing
              file_name - The file to read
     Returns: A 2D array
  
=end
def parse_csv_file(delim, file_name) 
    
  temp_array  = Array.new            #Create an array
  file  = File.open(file_name, "r")  #Open a file for reading
  
  
  #Iterate file, parse strings and store
  file.each_line do |line|
  temp_array.push(parse_line(delim, line))
  end

  #Close resource
  file.close
  
  return temp_array
end

