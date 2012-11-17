def parseLine (filename):
  file_content = loadFileList(filename)
  last_line = file_content[-1]
  split_line = last_line.split("\t")
  split_line = [int(x) for x in split_line]
  return split_line

# save the input file content into a list of strings 
# where each line is in a string
def loadFileList (filename):
  file_handler = open(filename, "rt")
  file_content = file_handler.readlines()
  file_handler.close()
  return file_content

# save a string into the given text file
def writeFileString (output_text, filename):
  file_handler = open(filename, "wt")
  file_handler.write(output_text)
  file_handler.close()

def oppositePosition (current):
  if (current > 6):
    return current - 6
  else: 
    return current + 6

def nextMove (inputfile,outputfile):
  last_line = parseLine(inputfile)
  print last_line
  if (last_line[4] > last_line[3]):
    new_position = oppositePosition(last_line[0])
  else:
    new_position = oppositePosition(last_line[1])
  writeFileString(str(new_position),outputfile)


nextMove("previous.txt","adv2pos.txt")

