#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat May 30 19:18:00 2020

@author: 
"""


import math
import numpy as np
import matplotlib.pyplot as plt

### FUNCTIONS

# function to move people
def MovePeople(people_pos, num_people, D):
    delxy = np.random.randn(num_people, 2) * math.sqrt(2 * D * t)
    people_pos_new = people_pos + delxy
    return(people_pos_new)

# write other functions here



### PARAMETERS 

# diffusion coefficient
D = 1.0

# time scale
t = 0.1

# number of people
num_people = 100

# people positions (start at zero)
people_pos = np.zeros((num_people, 2))  #creates a 100 by 2 array (columns for x and y, 100 people) 
                                        #and initialize to zero

# total number of steps for simulation
num_steps = 20


# size of plot (for visualization)
scale = 10

### HERE: CREATE VECTOR 
infected_vector = np.zeros((num_people, 1))
infected_vector[0] = 1
###


### RUN SIMULATION

for step in range(num_steps):
    
    # move your people once per step
    people_pos = MovePeople(people_pos, num_people, D)
    
    # plotting code!
    # COLOR ACCORDING TO infected_vector (replace line 51)
    #plt.scatter(people_pos[0:49, 0], people_pos[0:49, 1], 10, color = 'black')
    #plt.scatter(people_pos[50:99, 0], people_pos[50:99, 1], 10, color = 'red')
    
    colors = ["red" if inf else "black" for inf in infected_vector]
    plt.scatter(people_pos[:, 0], people_pos[:, 1], 10, c = colors)
    
    # no need to touch after here
    plt.axis("equal")
    plt.axis([-scale, scale, -scale, scale])
    plt.pause(0.1)
    
    