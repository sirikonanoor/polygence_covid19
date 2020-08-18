#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Jun  7 09:28:39 2020

@author: sirikonanoor
"""


import math
import numpy as np
import matplotlib.pyplot as plt

# you will want to import this:
from scipy.spatial import distance
##############################################################################

# FUNCTIONS

# function to create initial vector of infected people
def CreateInfectedVector(num_people, base_infection, base_immunity):
    
    # np.random.uniform(0, 1, num_people) gives
    # num_people numbers between 0 and 1    
    probabilities = np.random.uniform(low = 0,
                                      high = 1,
                                      size = num_people)

    # because they are from 0 to 1, you can think of
    # vector you just created as probabilities
    # then, you compare that to base_infection
    # if the probability is less than base_infection,
    # then you are set to 1 (TRUE) as infected!
    # This is a good way to simulate 10% of all people
    # being infected at the beginning of the simulation
    #infected_vector = probabilities < base_infection
    
    infected_vector = np.zeros(num_people)
    
    immune = np.logical_and(probabilities > base_infection, 
                                probabilities < base_immunity)
    infect = probabilities < base_infection
    
    infected_vector[immune] = 2
    infected_vector[infect] = 1
    
    return(infected_vector)

# function to move people
# hopefully this makes sense now!
def MovePeople(people_pos, num_people, D, delt):
    delxy = np.random.randn(num_people, 2) * math.sqrt(2 * D * delt)
    people_pos_new = people_pos + delxy
    
    outside_box = np.logical_or(people_pos_new > scale - 1,
                                people_pos_new < -(scale - 1))  
    
    #array has true if point is out of bounds
    outside_box2 = np.logical_or(outside_box[:,0], outside_box[:,1])
    
    people_pos_new[outside_box2] = people_pos[outside_box2]
    return(people_pos_new)


    

# infect people (HOMEWORK!)
def Infect(people_pos, infected_vector, critical_distance, vaccine_effectivity):
    distances = distance.cdist(people_pos, people_pos, 'euclidean')
    random_infect = np.random.uniform(low = 0, high = 1, size = num_people)
    
    # Create a boolean matrix indicating if people are within crit_dist of others.
    within = distances < critical_distance
    # Repeat the infected_vector num_people times.
    repeated = np.repeat(infected_vector,
                         num_people, axis = 0).reshape(num_people, num_people)
    # Check if people are within critical dist of an infected person.
    # Create a boolean for each person set to True if they are close to any
    # infected person.
    within_danger = np.any(np.logical_and(within, repeated==1), axis=0)
    # if a person is within crit dist of an infected person *and*
    # they are not vaccinated or they failed the vaccine effectivity lottery
    final = np.logical_and(within_danger, 
                           np.logical_or(infected_vector != 2,
                                         random_infect > vaccine_effectivity))
    # ... and they have not recovered or they lost the recovery lottery...
    final = np.logical_and(final,
                           np.logical_or(recovered != True,
                                         random_infect < 0.5))
    infected_vector[final] = 1
    
    return (infected_vector)


def updateRecovery(infected_vector, time_since_infected, recovery_time):
    equals1 = infected_vector == 1
    time_since_infected[equals1] += 1
    
    make_recover = time_since_infected == recovery_time
    infected_vector[make_recover] = 0
    recovered[make_recover] = True
    return infected_vector


# plot simulation
def PlotSim(positions, infected, scale, pause):
    colors = np.empty(infected.shape, dtype=object)
    
    colors[infected == 0] = "black"
    colors[infected == 1] = "red"
    colors[infected == 2] = "green"

    
    plt.scatter(x = positions[:, 0],
                y = positions[:, 1],
                s = 10,
                c = colors.tolist())
    plt.axis([-scale, scale, -scale, scale])
    plt.gca().set_aspect("equal", adjustable = "box")
    plt.pause(pause)
    
    
    
""" this method draws a graph that plots the number of infected people 
    at each step of the simulation
    
    @param counts   array that contains num of infected people for each step
    """
def PlotPerSimInfRate(counts):
    plt.plot(counts)
    plt.ylabel("Percent of Infected People")
    plt.xlabel("Simulation Number")
    #plt.ylim(0, 100)
    plt.show()
    plt.pause(3)

""" this method draws a graph of the number of infected people at the end of 
    num_sims number of sims
    
    @param counts   array that contains num of infected people at the end of each sim"""
def PlotOverSimInfRate(counts):
    plt.plot(counts)
    plt.ylabel("Percent of Infected People")
    plt.xlabel("Vaccination Effectivity")
    #plt.xlim(0, 1)
    #plt.xscale(0.1)
    #plt.ylim(0, 100)
    plt.show()


##############################################################################

# PARAMETERS 

# diffusion coefficient (km^2 per hour)
D = 4 * math.pi # 3.0 1.25

# time scale (hours), so 6 minutes
delt = 1.0 # 0.1

# number of people (try changing this!)
num_people = 2000


# size of map (in km)
# we are simulating SF, which is ~121 km^2
scale = 11

# people positions (uniformly distributed)
# type np.random.uniform(-1, 1, [5, 2]) in the console
# to make sure you understand how to use np.random.uniform()
people_pos = np.random.uniform(-(scale-1), (scale-1), [num_people, 2])

# total number of hours for simulation
# since delt = 0.1, this is equivalent to
# 100 iterations of for loop (shown below)
total_sim_time = 10.0

# calculate steps based on sim
# made into an integer (no decimals) because
# for loops need to use integers
# num_steps = int(total_sim_time / delt)
num_steps = 100
# number of simulations to run
num_sims = 5


# set initial rate of infection
# fraction of initial points that will be infected
# try playing around with this too!
base_infection = 0.3
# initial rate of immunity
base_immunity = 0.6

# create infected_vector for t=0 of simulation
# look at the function!
infected_vector = CreateInfectedVector(num_people, base_infection, base_immunity)
# counts the number of steps it has been since a point is infected
time_since_infected = np.zeros(num_people)

# create an array of ages with a distribution that tis specific to San Francisco
list_of_candidates = np.arange(0, 90)  
# SF population distribution by age range
# obtained from: https://censusreporter.org/profiles/16000US0667000-san-francisco-ca/
probability_distribution = np.concatenate([np.full(10, 0.008), 
                                            np.full(10, 0.007), 
                                            np.full(10, 0.017), 
                                            np.full(10, 0.021), 
                                            np.full(10, 0.014), 
                                            np.full(10, 0.012), 
                                            np.full(10, 0.011), 
                                            np.full(10, 0.006), 
                                            np.full(10, 0.004)])
ages = np.random.choice(list_of_candidates, size=num_people, p=probability_distribution)

"""ages = np.random.uniform(low = 0,           #this produces random numbers with mean = 40 (the mean age in SF)
                          high = 81,
                          size = num_people)"""

# critical distance for infection
# play with this to make sure you understand it!
critical_distance = 0.1
# critical_distance = ages/300
# time till recovery after infection
recovery_time = 14

recovered = np.full(num_people, False)
vaccine_effectivity = 0.4

# plot simulation at t = 0
# aka what the simulation looks like
# before people start moving
PlotSim(people_pos, infected_vector, scale, pause = 1)

##############################################################################

# RUN SIMULATION

# remember that every step is worth 0.1 hours (set by delt)

#this holds the number of people infected at the end of each simulation
# over_sim = []
# for sim in range(num_sims):
    
#     vaccine_effectivity += 0.1   
#     people_pos = np.random.uniform(-(scale-1), (scale-1), [num_people, 2])
#     infected_vector = CreateInfectedVector(num_people, base_infection, base_immunity)
#     # this holds the number if infected people after each step within a simulation
per_sim = []


for step in range(num_steps):
    # move your people once per step
    # hopefully this function makes sense!
    people_pos = MovePeople(people_pos, num_people, D, delt)
        
    # infect people 
    # homework is to write this function!
    infected_vector = Infect(people_pos, infected_vector, critical_distance, vaccine_effectivity)
        
    nums_of_1 = np.count_nonzero(infected_vector == 1)
    per_sim.append((nums_of_1/num_people)*100)
       
    infected_vector = updateRecovery(infected_vector, time_since_infected, recovery_time)
        
    # plot each step of sim
    # this just groups all the plotting code
    PlotSim(people_pos, infected_vector, scale, pause = 0.000001)


PlotPerSimInfRate(per_sim)
nums_of_1 = np.count_nonzero(infected_vector == 1)
# over_sim.append((nums_of_1/num_people)*100)
    

# PlotOverSimInfRate(over_sim)