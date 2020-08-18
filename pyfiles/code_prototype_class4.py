#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Jun  7 09:28:39 2020
Edited on Tue Jun 16 11:47:45 2020

@author: sirikonanoor
@editor: fabianortega
"""


import math
import numpy as np
import matplotlib.pyplot as plt

# you will want to import this:
from scipy.spatial import distance
##############################################################################

# FUNCTIONS

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
def PlotOverSimInfRate(counts, vaccine_eff):
    plt.plot(vaccine_eff, counts)
    plt.ylabel("Percent of Infected People")
    plt.xlabel("Vaccination Effectivity")
    #plt.xlim(0, 1)
    #plt.xscale(0.1)
    #plt.ylim(0, 100)
    plt.show()
    
# function to create initial vector of infected people
def CreateInfectedVector(num_people, base_infection, base_immunity):
    
    ### FO: always a good idea to have a note here
    ### as to what each of the parameters are
    ### eg:
        # num_people = integer showing population
        # base_infection = # of people infected at t=0
        # base_immunity = # of people who cannot be infected
    
    # assign probabilities
    probabilities = np.random.uniform(low = 0,
                                      high = 1,
                                      size = num_people)

    # create vector
    infected_vector = np.zeros(num_people)
    
    ### FO: we need to be clear about this
    ### if base_inf is 0.1 and base_imm = 0.1, then this
    ### won't work, right? Let's talk about how to better
    ### code this...
    immune = np.logical_and(probabilities > base_infection, 
                                probabilities < base_immunity)
    
    # yes, this is perfect
    infect = probabilities < base_infection
    
    # perfect!
    infected_vector[immune] = 2
    infected_vector[infect] = 1
    
    return(infected_vector)


# function to move people
### FO: you need to pass "scale" into the function!
def MovePeople(people_pos,
               num_people,
               D,
               delt):
    
    ### vars:
        # people_pos = positions (2D array)
        # num_people = size of population (int)
        # D = diffusion coefficient (float)
        # delt = time delta (float)
    
    # calculate displacement
    delxy = np.random.randn(num_people, 2) * math.sqrt(2 * D * delt)
    
    # move people
    people_pos_new = people_pos + delxy
    
    # check if x or y coordinates outside of box
    ### FO: I think you don't need to decrease by 1?
    outside_box = np.logical_or(people_pos_new > scale - 1,
                                people_pos_new < -(scale - 1))  
    
    # array has true if point is out of bounds
    outside_box2 = np.logical_or(outside_box[:,0],
                                 outside_box[:,1])
    
    ### FO: beautiful!
    people_pos_new[outside_box2] = people_pos[outside_box2]
    return(people_pos_new)


### TALK ABOUT THIS!!!
# infect people (HOMEWORK!)
def Infect(people_pos,
           infected_vector,
           critical_distance,
           vaccine_effectivity):
    
    random_infect = np.random.uniform(low = 0,
                                      high = 1,
                                      size = num_people)
    ### FO: excellent place for some optimization! Why do we need to
    ### check everyone for everyone? You're doing some unncessary
    ### distance calculations here!
    # distances = distance.cdist(people_pos, people_pos, 'euclidean')
    
    # # Create a boolean matrix indicating if people are within crit_dist of others.
    # within = distances < critical_distance
    # # Repeat the infected_vector num_people times.
    # repeated = np.repeat(infected_vector,
    #                       num_people, axis = 0).reshape(num_people, num_people)
    # # Check if people are within critical dist of an infected person.
    # # Create a boolean for each person set to True if they are close to any
    # # infected person.
    # within_danger = np.any(np.logical_and(within,
    #                                       repeated==1),
    #                         axis=0)
    
    ### FO's code
    infe = infected_vector == 1
    infected_pos = people_pos[infe]
    distance_to_infected = distance.cdist(people_pos,
                                          infected_pos,
                                          "euclidean")
    close_ind = distance_to_infected <= critical_distance
    close_to_infected = np.sum(close_ind, axis = 1) >= 2
    within_danger = close_to_infected | infe
    
    
    # if a person is within crit dist of an infected person *and*
    # they are not vaccinated or they failed the vaccine effectivity lottery
    ### FO: let's talk about this
    ### also, we are assuming everyone was vaccinated, right?
    ### that's another parameter we can vary!
    
    vaccine_lottery = np.logical_and(infected_vector != 2,
                                     random_infect < vaccine_effectivity)
    within_danger[vaccine_lottery] = 0
    
    # final = np.logical_and(within_danger, 
    #                        np.logical_or(infected_vector != 2,
    #                                      random_infect > vaccine_effectivity))
    # ... and they have not recovered or they lost the recovery lottery...
    ### FO: does this mean there is a 50% chance of just not becoming inf?
    
    resisted = np.logical_and(recovered,
                              random_infect < 0.5)
    within_danger[resisted] = 0
    
    # final = np.logical_and(final,
    #                        np.logical_or(recovered != True,
    #                                      random_infect < 0.5))
    infected_vector[within_danger] = 1
    
    return (infected_vector)


### FO: let's add some variable names!
def updateRecovery(infected_vector,
                   time_since_infected,
                   recovery_time):
    
    ### Vars:
        # infectec_vector: vector of 0s (uninf), 1s (inf), 2 (immune)
        # time_since_infected: number of steps
        # recovery_time: how long before it's healed
        
    ### FO: here, you're looking for infected people, so we should
    ### name the vector with something like that
    ### perhaps we should change the name of infected_vector too?
    equals1 = infected_vector == 1
    time_since_infected[equals1] += 1
    
    ### it's good style to just use >= sign here
    ### we can talk about why
    make_recover = time_since_infected == recovery_time
    
    ### do you want to make them healthy? Perhaps
    ### we can make them immune?
    infected_vector[make_recover] = 0
    
    ### ummm, this should be an argument of the function!
    recovered[make_recover] = True
    return infected_vector


##############################################################################

# PARAMETERS 

# diffusion coefficient (km^2 per hour)
D = 1.25
### FO: how come we changed this?

# time scale (hours), so 6 minutes
delt = 0.1

# number of people (try changing this!)
num_people = 1000

# size of map (in km) we are simulating SF, which is ~121 km^2
scale = 11.0

# people positions (uniformly distributed)
# type np.random.uniform(-1, 1, [5, 2]) in the console
# to make sure you understand how to use np.random.uniform()
people_pos = np.random.uniform(-(scale - 1), (scale - 1), [num_people, 2])

# total number of hours for simulation
# since delt = 0.1, this is equivalent to
# 100 iterations of for loop (shown below)
total_sim_time = 5.0

# calculate steps based on sim
# made into an integer (no decimals) because
# for loops need to use integers
num_steps = int(total_sim_time / delt)
# number of simulations to run
num_sims = 6

# set initial rate of infection
# fraction of initial points that will be infected
# try playing around with this too!
base_infection = 0.1

# initial rate of immunity
# half the people
base_immunity = 0.5

# create infected_vector for t=0 of simulation
# look at the function!
infected_vector = CreateInfectedVector(num_people, base_infection, base_immunity)
# counts the number of steps it has been since a point is infected
time_since_infected = np.zeros(num_people)

### FO: you can actually just do: np.arange(90)  !
# create an array of ages with a distribution that tis specific to San Francisco
list_of_candidates = np.arange(0, 90)
# SF population distribution by age range
# obtained from: https://censusreporter.org/profiles/16000US0667000-san-francisco-ca/

### FO: woah! Impressive detective work! Just, made
### a small suggestion on how to make the code more compact
    
# probability_distribution = np.concatenate([np.full(10, 0.008), 
#                                             np.full(10, 0.007), 
#                                             np.full(10, 0.017), 
#                                             np.full(10, 0.021), 
#                                             np.full(10, 0.014), 
#                                             np.full(10, 0.012), 
#                                             np.full(10, 0.011), 
#                                             np.full(10, 0.006), 
#                                             np.full(10, 0.004)])

# comment, eg: number of age buckets
buckets = 10
prob_distr_sf = np.array([0.008, 0.007, 0.017,
                          0.021, 0.014, 0.012,
                          0.011, 0.006, 0.004])

prob_distr_full = np.repeat(prob_distr_sf, buckets)

ages = np.random.choice(list_of_candidates,
                        size = num_people,
                        p = prob_distr_full)


# critical distance for infection
# play with this to make sure you understand it!
critical_distance = 0.5
# critical_distance = ages/300
# time till recovery after infection
recovery_time = 14

recovered = np.full(num_people, False)

### FO: comments, comments, comments
vaccine_eff = []
vaccine_effectivity = 0.0

# plot simulation at t = 0
# aka what the simulation looks like
# before people start moving
# PlotSim(people_pos, infected_vector, scale, pause = 1)

##############################################################################

# RUN SIMULATION

# remember that every step is worth 0.1 hours (set by delt)

#this holds the number of people infected at the end of each simulation
over_sim = []
### FO: I would stick to numpy here
### it will more easily allow you to hold all your data
import time
t = time.time()
for sim in range(num_sims):
    
    ### FO: this means you're starting with eff of 0.2 ?
    # vaccine_effectivity += 0.1
    
    ### FO: save vaccine values
    vaccine_eff.append(vaccine_effectivity)
    
    ### FO: this works well
    people_pos = np.random.uniform(low = -(scale-1),
                                   high = (scale-1),
                                   size = [num_people, 2])
    infected_vector = CreateInfectedVector(num_people, base_infection, base_immunity)
    # this holds the number if infected people after each step within a simulation
    per_sim = []
    
    
    for step in range(num_steps):
        
        # move your people once per step
        # hopefully this function makes sense!
        people_pos = MovePeople(people_pos, num_people, D, delt)
            
        # infect people 
        # homework is to write this function!
        infected_vector = Infect(people_pos, infected_vector, critical_distance, vaccine_effectivity)
            
        nums_of_1 = np.count_nonzero(infected_vector == 1)
        
        ### FO: I would define: nums_of_1/num_people
        ### percent_infected = (nums_of_1 / num_people) * 100
        ### per_sim.append(percent_infected)
        per_sim.append((nums_of_1/num_people)*100)
        
        ### nice job calling this function
        ### need to add the Recovered vector here too...
        infected_vector = updateRecovery(infected_vector, time_since_infected, recovery_time)
        
        # plot each step of sim
        # this just groups all the plotting code
        # PlotSim(people_pos, infected_vector, scale, pause = 0.000001)
        
        ### FO: slight problem here: you lose per_sim from other sims!
        ### good reason to use Numpy arrays
    
    PlotPerSimInfRate(per_sim)
    nums_of_1 = np.count_nonzero(infected_vector == 1)
    over_sim.append((nums_of_1/num_people)*100)
    
    vaccine_effectivity += 0.2
    

PlotOverSimInfRate(over_sim, vaccine_eff)

print(time.time() - t)