


def firstLineParser(firstline):
  firstline = firstline.split()
  return int(firstline[-1])

def parseContent(filename):
  file_content = loadFileList(filename)
  file_content = file_content [2:]
  position1 = []
  position2 = []
  position3 = []

  for line in file_content:
          split_line = line.split()
          file_line = [int(x) for x in split_line]
          position1+=[ file_line[0] ]
          position2+=[ file_line[1] ]
          position3+=[ file_line[2] ] 
  return (position1,position2,position3)

# Final Answer 
# 1 -> Random
# 2 -> Stick
# 3 -> Follow
def findStrategy(position1,position2,position3):
        position1 = position1[-10:]
        position2 = position2[-10:]
        position3 = position3[-10:]
        
        stick2 = True
        stick3 = True
        follow2 = True
        follow3 = True
        final2 = 1 
        final3 = 1
        for i in range(1,10):
            if (position2[i]!=position2[i-1]):
                  stick2 = False
            if (position3[i]!=position3[i-1]):
                  stick3 = False
        for i in range(0,10):
            if (abs(position2[i]-position3[i])!=6 and (abs(position2[i]-position3[i])!=6)   ): 
                  follow2 = False
            if (abs(position2[i]-position3[i])!=6 and (abs(position2[i]-position3[i])!=6)   ):
                  follow3 = False
         
        if (stick2):
                final2 = 2
        if (stick3):
                final3 = 2
        if ((not stick2) and follow2):
                final2 = 3
        if ((not stick) and follow3):
                final3 = 3
        return (final2,final3)


def parseLine (filename):
  file_content = loadFileList(filename)
  first_line = file_content[0]
  #print "First Line ",first_line
  first_line = first_line.split(" ")
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
  if (last_line[7] > last_line[8]):
    new_position = oppositePosition(last_line[2])
  else:
    new_position = oppositePosition(last_line[1])
  writeFileString(str(new_position),outputfile)


nextMove("previous.txt","position.txt")

