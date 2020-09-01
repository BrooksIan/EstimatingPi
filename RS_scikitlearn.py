import numpy as np
from scipy import random
a, b = 0, np.pi # limits of integration
N = 100_000     # Number of random points
integral = 0.0  # initialize the value of the integral
x_random = random.uniform(a,b,N) # array of random numbers
def func(x):
    '''This is the function that we want to integrate'''
    return np.sin(x)
# Makes a guess at the integral, adds that guess to the other guesses, and prints intermediate answers
for x in range(N):
    integral += func(x_random[x])
    if (x % 10_000 == 0) & (x != 0):
        intermediate_answer = (b-a)/float(x)*integral
        print(f'Value after {x} iterations is {intermediate_answer}')
    
answer = (b-a)/float(N)*integral
print(f'The value of the integral from {a} to {b} is: ', answer)