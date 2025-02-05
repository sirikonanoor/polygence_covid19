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

from scipy.spatial import distance
##############################################################################

# FUNCTIONS

# plot simulation
 # params:
    # positions = the x and y coordinates of each point (2D array)
    # infected = stores the health state of every point (1D array)
    # scale = sets the boundary for the plot (int)
    # pause = amount of time to pause before showing next plot (float)
def PlotSim(positions,
            infected,
            scale,
            pause):
    
    colors = np.empty(infected.shape, dtype=object)
    
    colors[infected == 0] = "black"
    colors[infected == 1] = "red"
    colors[infected == 2] = "green"

    
    plt.scatter(x = positions[:, 0],
                y = positions[:, 1],
                s = 10,
                c = colors.tolist())
    plt.axis([-scale,
              scale,
              -scale,
              scale])
    plt.gca().set_aspect("equal", adjustable = "box")
    plt.pause(pause)


# this method draws a graph that plots the number of infected people 
    # at each step of the simulation
 # params:
    # counts = array that contains num of infected people for each step (1D array)
def PlotPerSimInfRate(counts):
    plt.plot(counts)
    plt.ylabel("Percent of Infected People")
    plt.xlabel("Simulation Number")
    plt.show()
    plt.pause(3)


# this method draws a graph of the number of infected people at the end of 
    # num_sims number of sims
 # params:
    # counts = array that contains num of infected people at the end of each sim (1D array)
def PlotOverSimInfRate(counts, vaccine_eff):
    plt.plot(vaccine_eff, counts)
    plt.ylabel("Percent of Infected People")
    plt.xlabel("Vaccination Effectiveness")
    plt.show()
   
    
# function to create initial vector of infected people
 # params:
    # num_people = size of population (int)
    # base_infection = # of people infected at t=0 (int)
    # base_vaccination = # of people who cannot be infected (int)
def CreateInfectedVector(num_people,
                         base_infection,
                         base_vaccination):
    
    # assign probabilities
    probabilities = np.random.uniform(low = 0,
                                      high = 1,
                                      size = num_people)

    # create vector
    infected_vector = np.zeros(num_people)
    
    # a boolean vector that has True wherever a corresponding point in infected_vector
            # is vaccinated
    vaccinated = np.logical_and(probabilities > base_infection, 
                                probabilities < (base_vaccination + base_infection))
    
    # a boolean vector that has True wherever a corresponding point in infected_vector
            # is infected
    infect = probabilities < base_infection
    
    infected_vector[vaccinated] = 2
    infected_vector[infect] = 1
    
    return(infected_vector)


# function to move people
 ### params:
    # people_pos = positions (2D array)
    # num_people = size of population (int)
    # D = diffusion coefficient (float)
    # delt = time delta (float)
def MovePeople(people_pos,
               num_people,
               D,
               delt,
               scale):
    
    # calculate displacement
    delxy = np.random.randn(num_people, 2) * math.sqrt(2 * D * delt)
    
    # move people
    people_pos_new = people_pos + delxy
    
    # check if x or y coordinates outside of box
    outside_box = np.logical_or(people_pos_new > scale,
                                people_pos_new < -scale)  
    
    # array has true if point is out of bounds
    outside_box2 = np.logical_or(outside_box[:, 0],
                                 outside_box[:, 1])
    
    people_pos_new[outside_box2] = people_pos[outside_box2]
    return(people_pos_new)

# function to infect people
 # params:
    # people_pos = the x and y coordinates of each point (2D array)
    # infected_vector = stores the health state of every point (1D array)
def Infect(people_pos,
           infected_vector,
           critical_distance,
           vaccine_effectiveness,
           susceptibility):
    
    random_infect = np.random.uniform(low = 0,
                                      high = 1,
                                      size = num_people)

    infe = infected_vector == 1
    infected_pos = people_pos[infe]
    distance_to_infected = distance.cdist(people_pos,
                                          infected_pos,
                                          "euclidean")
    close_ind = distance_to_infected <= critical_distance
    close_to_infected = np.sum(close_ind, axis = 1) >= 1
    within_danger = close_to_infected | infe
    
    
    vaccine_lottery = np.logical_and(infected_vector == 2,
                                     random_infect < vaccine_effectiveness)
    within_danger[vaccine_lottery] = False
    
    ### FO: does this mean there is a 50% chance of just not becoming inf?
    
    resisted = np.logical_and(recovered,
                              random_infect < 0.5)
    within_danger[resisted] = False
    
    # check susceptibility
    not_susceptible = susceptibility < random_infect * 100 
    within_danger[not_susceptible] = False
    
    infected_vector[within_danger] = 1
    
    return (infected_vector)


def updateRecovery(infected_vector,
                   time_since_infected,
                   recovery_time,
                   recovered):
    
    ### Vars:
        # infectec_vector: vector of 0s (uninf), 1s (inf), 2 (vaccinated)
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

import matplotlib.pyplot as py
def PlotBoxPlots(same_parameter_repeat):
    fig = py.figure(1, figsize=(9, 6))

    # Create an axes instance
    ax = fig.add_subplot(111)
    
    # Create the boxplot
    bp = ax.boxplot(same_parameter_repeat)
    
    # Save the figure
    # fig.savefig('fig1.png', bbox_inches='tight')


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
### FO: we now don't need this here since it's overwritten lower down
people_pos = np.random.uniform(-(scale - 1),
                               (scale - 1),
                               [num_people, 2])

# total number of hours for simulation
# since delt = 0.1, this is equivalent to
# 100 iterations of for loop (shown below)
total_sim_time = 5.0

# calculate steps based on sim
# made into an integer (no decimals) because
# for loops need to use integers
num_steps = int(total_sim_time / delt)
# number of simulations to run
num_sims = 1
# number of times to repeat a sim with the same parameters
num_repeats = 10

# set initial rate of infection
# fraction of initial points that will be infected
# try playing around with this too!
base_infection = 0.1

# initial rate of vaccinated people
base_vaccination = 0.4

# create infected_vector for t=0 of simulation
# look at the function!
infected_vector = CreateInfectedVector(num_people,
                                       base_infection,
                                       base_vaccination)

# counts the number of steps it has been since a point is infected
### FO: FOUND THE BUG! YAY!
time_since_infected = np.zeros(num_people)

### FO: you can actually just do: np.arange(90)  !
# create an array of ages with a distribution that tis specific to San Francisco
list_of_candidates = np.arange(0, 90)
# SF population distribution by age range
# obtained from: https://censusreporter.org/profiles/16000US0667000-san-francisco-ca/

# comment, eg: number of age buckets
buckets = 10
prob_distr_sf = np.array([0.008, 0.007, 0.017,
                          0.021, 0.014, 0.012,
                          0.011, 0.006, 0.004])

prob_distr_full = np.repeat(prob_distr_sf, buckets)

ages = np.random.choice(list_of_candidates,
                        size = num_people,
                        p = prob_distr_full)

# from https://www.nature.com/articles/s41591-020-0962-9/figures/1
susceptibility = ages * 0.15


# critical distance for infection
critical_distance = 5.0
recovery_time = 14


##############################################################################

# RUN SIMULATION

# remember that every step is worth 0.1 hours (set by delt)

### FO: let's put all imports at the top
import time
t = time.time()
### FO: LET'S DISCUSS!!

# determine parameters you want to change!
vaccine_eff = np.arange(start = 0,
                        stop = 1.1,
                        step = 0.1)

# how many parameters do you have?
data = np.zeros((len(vaccine_eff), 2))

# store them all in the first column
data[:, 0] = vaccine_eff

# repeat them as many times as you want
data = np.repeat(data,
                 repeats = 5,
                 axis = 0)

# calculate total number of sims
num_sims = np.shape(data)[0]

# this holds the number if infected people after each step within a simulation
### FO: yes, this works well now, I changed 4 for "num_repeats"
for sim in range(num_sims):

    ### FO: unpack value :)
    vaccine_effectiveness = data[sim, 0]

    ### FO: THIS WAS AN IMPORTANT PIECE OF CODE!!!
    time_since_infected = np.zeros(num_people)

    # declare new arrays for a new experiment:
    # (1) recovered from disease
    recovered = np.full(num_people, False)

    # (2) initial positions
    people_pos = np.random.uniform(low = -(scale - 1),
                                   high = (scale - 1),
                                   size = [num_people, 2])
 
    # (3) create infected vector
    infected_vector = CreateInfectedVector(num_people,
                                           base_infection,
                                           base_vaccination)

    # loop through steps of simulation!
    for step in range(num_steps):

        # move!
        people_pos = MovePeople(people_pos,
                                num_people,
                                D,
                                delt,
                                scale)

        # infect!
        infected_vector = Infect(people_pos,
                                 infected_vector,
                                 critical_distance,
                                 vaccine_effectiveness,
                                 susceptibility)

        # recover!
        infected_vector = updateRecovery(infected_vector,
                                         time_since_infected,
                                         recovery_time,
                                         recovered)

    ### FO: remember, we need better names than "nums_of_1"
    ### FO: can just use np.sum()
    nums_of_1 = np.sum(infected_vector == 1)
    percent_infected = (nums_of_1 / num_people) * 100
    data[sim, 1] = percent_infected

# print time
print("TIME = " + str(time.time() - t) + " seconds")

# save data as .csv
np.savetxt(fname = "/Users/sirikonanoor/Documents/Polygence/vaccine_efficacy.csv",
           X = data,
           delimiter = ",")