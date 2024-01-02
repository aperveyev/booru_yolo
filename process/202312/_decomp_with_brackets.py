import os
import sys
from pathlib import Path

with open(sys.argv[1], 'r') as fr: # '_decomp.tsv'
 for line in fr:
#   print(line.split('\t')[0])
   with open(line.split('\t')[0].lstrip('"'), 'a') as fw:
     fw.write(line.split('\t')[1].replace('"',''))
   fw.close()   
fr.close
