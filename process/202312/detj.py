# draw boxes and lines over torso components
# first line of input file (with hardcoded name now) is
#"IDX";"FNAME";"HOBJ";"PROB";"X";"Y";"W";"H";"OBJ";"OPROB";"OX";"OY";"OW";"OH";"ONAME";"OID";"BOID"
import cv2
import pandas as pd
import numpy as np
import sys

prev_fname = 'NONE'
prev_oname = 'NONE'
data = pd.read_csv(sys.argv[1],sep=';', decimal=',',index_col='IDX')

for i, row in data.iterrows():
   print(str(i)+' '+row['FNAME'])
   if row['FNAME']!=prev_fname:
      image = cv2.imread(row['FNAME'])
      ih, iw, _ = image.shape
      print(str(i) + ' RD ' + row['FNAME'])
      if row['ONAME']!=prev_oname and prev_oname!='NONE':
#         jfl = open(prev_oname.replace('.jpg','.txt'), 'a')
#         jfl.write(prev_line+'\n')
#         jfl.close()
         cv2.imwrite(prev_oname, prev_image)
         print(str(i)+' WR '+prev_oname)
      prev_oname=row['ONAME']
      prev_fname=row['FNAME']
      prev_image = image
   lnw = int(min(ih, iw) / 96)
   lnwr = int(min(ih, iw) / 96)

   if row['HOBJ'] in ('head','hdrago','hpony','hfox','hrabb','hcat','hbear','hhorse','hbird'):
      colr = (51, 153, 102) # green
      lnw = int(lnwr*0.6)
   if row['HOBJ'] in ('shld','bust'):
      colr = (255, 153, 0) # light blue
      lnw = int(lnwr*0.5)
   if row['HOBJ'] in ('sideb','boob'):
      colr = (0, 153, 255) # orange
      lnw = int(lnwr*0.6)
   if row['HOBJ'] in ('arew'):
      colr = (160, 160, 160) # (176, 176, 176) # light gray
      lnw = int(lnwr*0.4)
   if row['HOBJ'] in ('areb'):
      colr = (102, 102, 0) # (16, 16, 16) # almost black
      lnw = int(lnwr*0.4)
   if row['HOBJ'] in ('feral'):
      colr = (0, 77, 155) # brown
      lnw = int(lnwr*0.4)
   if row['OBJ']=='none':
      colr = (32, 32, 32) # dark gray
      lnw = int(lnwr*0.4)
   prev_image = cv2.rectangle( prev_image, (row['X'], row['Y']),\
                               (row['X']+row['W'], row['Y']+row['H']), colr, max(lnw, 4) )
   cv2.putText(prev_image, row['HOBJ']+' '+row['OID']+' '+str(row['PROB']), (row['X']+lnw, row['Y']+5*lnw), 0, lnw / 6, colr, thickness=int(lnw/2), lineType=cv2.LINE_AA)

   if row['OBJ']!='none' :
      if row['OBJ'] in ('bust','shld'):
         colr = (255, 153, 0) # light blue
         lnw = int(lnwr*0.5)
      if row['OBJ'] in ('sideb','boob','jacko','jackx'):
         colr = (0, 153, 255) # orange
         lnw = int(lnwr*0.6)
      if row['OBJ'] in ('split','vsplt','butt','belly','hip'):
         colr = (153, 0, 153) # violet
         lnw = int(lnwr*0.5)
      if row['OBJ'] in ('ass','nopan','sprd','vsprd'):
         colr = (0, 0, 255) # red
         lnw = int(lnwr*0.6)
      if row['OBJ'] in ('wing','feral'):
         colr = (0, 77, 155) # brown
         lnw = int(lnwr*0.4)

      prev_image = cv2.line( prev_image, (int(row['X']+row['W']/2), int(row['Y']+row['H']/2)),\
                             (int(row['OX']+row['OW']/2), int(row['OY']+row['OH']/2)),colr, max(lnw, 4) )
      prev_image = cv2.rectangle( prev_image, (row['OX'], row['OY']),\
                                  (row['OX']+row['OW'], row['OY']+row['OH']), colr, max(lnw, 4) )
      cv2.putText(prev_image, row['OBJ']+' '+row['BOID']+' '+str(row['OPROB']), (row['OX']+lnw, row['OY']+5*lnw), 0, lnw / 6, colr, thickness=int(lnw/2), lineType=cv2.LINE_AA)

   prev_line = '0 '+str(round(row['OX']/iw,6))+' '+str(round(row['OY']/ih,6))+' '+str(round(row['OW']/iw,6))+' '+str(round(row['OH']/ih,6))

cv2.imwrite(prev_oname, prev_image)
print(str(i) + ' WR ' + prev_oname)
