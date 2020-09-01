# # Estimating $\pi$
#
# This Python example shows you how to estimate $\pi$
# using Randon Sampleing integration.

#python3 - Forked code can be found below
#https://medium.com/@utkuarik/estimating-pi-value-with-monte-carlo-simulation-python-5d8a2cedbab9


import random
import math
import cdsw
import time
import sys 

##Set Default Value
defaultVal = 100000

### Euclidean distance calculator 
def dist_cal (x1, y1 ,x2, y2):
    distance = math.sqrt((x1 - x2)**2 + (y1 -y2)**2)
    
    return distance
### Random points generator
def create_random(n_val):
    point_list = []
    for x in range(n_val):
        x = random.randint(-10000,10000)
        y = random.randint(-10000,10000)
        
        point_list.append([x,y])
    return point_list

## Start Simulation 

# Set Number of Samples
if( (len(sys.argv)-1) > 0):
  if(sys.argv[1] != None):
    n_val=int(sys.argv[1])
  else:
    n_val = defaultVal

#Default Value
else:
  n_val = defaultVal

### Start Timer
startTime = time.process_time()
  
inside = 0
outside = 0

  
points = create_random(n_val)
  
for i in points:
    if dist_cal(i[0],i[1], 0,0) <= 10000:
        inside = inside +1
  
PiEst = 4*inside / (n_val)
"Estimate of Pi is %0.8f" % (PiEst)


### Stop Timer
stopTime = time.process_time()
elapsedTime = stopTime-startTime

"Elapsed Process Time: %0.8f" % (elapsedTime)

#Return Paramaters to CDSW User Interface
cdsw.track_metric("NumIters", n_val)
cdsw.track_metric("PiEst", PiEst)
cdsw.track_metric("ProcTime", elapsedTime)