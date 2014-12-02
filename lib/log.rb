require 'termcolorlight'

def warn(str)
  puts str
end

def error(str)
  puts("<bold><red>[ERROR]</red></bold> #{str.escape}".termcolor)
end
