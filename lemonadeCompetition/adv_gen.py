import random
from optparse import OptionParser
parser = OptionParser()
parser.add_option("-M","--moves",dest="moves",type="int",help="write adversary moves for 1 and 2",default=6)

(options,args) = parser.parse_args()

moves = options.moves

# save a string into the given text file
def writeFileString (output_text, filename):
  file_handler = open(filename, "wt")
  file_handler.write(output_text)
  file_handler.close()

# decide the next move of adv1
#def n1(inputfile, outputfile):
def nRandom(moves,outputfile):
  outputstr = ""  
  for i in range(moves):
    next_move = random.randrange(1,13)
    outputstr += str(next_move) + "\n"
  writeFileString(outputstr,outputfile)


nRandom(moves,"adversary1.txt")
nRandom(moves,"adversary2.txt")
