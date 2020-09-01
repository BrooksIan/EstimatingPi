# # Estimating $\pi$
#
# This PySpark example shows you how to estimate $\pi$ in parallel
# using Randon Sampleing integration.

from __future__ import print_function
import sys
import time
import cdsw 
from random import random
from operator import add

# Connect to Spark by creating a Spark session
from pyspark.sql import SparkSession

# Set Default Value
defaultVal = 1000000
defaultParitions = 8
n_val = defaultVal

# Establish Spark Connection
spark = SparkSession\
    .builder\
    .appName("PythonPi")\
    .getOrCreate()

    
# Start Simulation 

# Set Number of Samples
if( (len(sys.argv)-1) > 0):
  if(sys.argv[1] != None):
    n_val=int(sys.argv[1])

# Start Timer
startTime = time.process_time()    
    
partitions = defaultParitions
n = n_val * partitions

def f(_):
    x = random() * 2 - 1
    y = random() * 2 - 1
    return 1 if x ** 2 + y ** 2 < 1 else 0

# To access the associated SparkContext
count = spark.sparkContext.parallelize(range(1, n + 1), partitions).map(f).reduce(add)

PiEst = 4.0 * count / n
print("Pi is estimated at %0.8f" % (PiEst))

# Stop Timer
stopTime = time.process_time()
elapsedTime = stopTime-startTime

print("Elapsed Process Time: %0.8f" % (elapsedTime))

# Return Paramaters to CDSW User Interface
cdsw.track_metric("NumIters", n_val)
cdsw.track_metric("PiEst", PiEst)
cdsw.track_metric("ProcTime", elapsedTime)

# Stop Spark Connection
spark.stop()