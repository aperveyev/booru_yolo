import glob
import os
from pathlib import Path

files = sorted(glob.glob('**/*.txt', recursive=True))

for ff in files:
  with open(ff, 'r') as t:
   for line in t:
#     if line.strip().startswith('14'):
       print(ff+'\t'+line.strip())
   t.close()   
