#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jun  9 21:16:12 2020

@author: fabianortega
"""

import numpy as np

### how do you pick 10% of points?

# sample from uniform
points = np.random.uniform(low = 0.0,
                           high = 1.0,
                           size = 10)

# how many are under 0.10 (aka 10%)
ten_percent_points = points <= 0.10

# fraction (should be 10%)
final_answer = np.sum(ten_percent_points) / np.size(points)
print(final_answer)




### distribution of integers (ages)
### let's talk about the params
ages = np.random.randint(low = 0,
                         high = 11,
                         size = 10000000)
print(np.mean(ages))



### relate to critical distance




### store values outside of sim
num_sims = 10
stored_vals = np.zeros(num_sims)

for sim in range(num_sims):
    # run sim
    # store value
    stored_vals[sim] = sim**2
    
print(stored_vals)



### check if inside box!

# define size of box
box = 5

# random people pos (for 100 people)
people_pos = np.random.uniform(-10, 10, [100, 2])

# check if any number > 5 or < 5

outside_box = np.logical_or(people_pos > box,
                            people_pos < -box)

# final outside (compare x and y to each other)
# because if either x or y are outside box, then
# the whole thing is outside the box
outside_box2 = np.logical_or(outside_box[:,0], outside_box[:,1])




def Infect(people_pos, infected_vector, critical_distance):
    distances = distance.cdist(people_pos, people_pos, 'euclidean')
    within = distances < critical_distance
    repeated = np.repeat(infected_vector, num_people, axis = 0).reshape(num_people, num_people)
    within_danger = np.any(np.logical_and(within, repeated==1), axis=0)
    final = np.logical_and(within_danger, infected_vector != 2)
    infected_vector[final] = 1
    return (infected_vector)
    
    
    """for r in range(distances.shape[0]): 
        for c in range(distances.shape[1]):
            #if the two points aren't the same AND neither point is immune
            if(r != c and (infected_vector[r] != 2 and infected_vector[c] != 2)):
                if(distances[r][c] < critical_distance and (infected_vector[r] == 1 or
                                                            infected_vector[c] == 1)):
                    new_inf_vector[r] = 1   #infect both
                    new_inf_vector[c] = 1"""
    





