#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Jul  2 14:47:02 2020

@author: sirikonanoor
"""


import math
import numpy as np
import matplotlib.pyplot as plt

from scipy.spatial import distance

import time
##############################################################################

# FUNCTIONS

# plot simulation
 # params:
    # positions = the x and y coordinates of each point (2D array)
    # infected = stores the health state of every point (1D array)
    # scale = sets the boundary for the plot (int)
    # pause = amount of time to pause before showing next plot (float)
def PlotSim(positions,
            health_state,
            scale,
            pause):
    
    colors = np.empty(health_state.shape, dtype=object)
    
    colors[health_state == 0] = "black"
    colors[health_state == 1] = "red"
    colors[health_state == 2] = "green"
    colors[health_state == 3] = "#d742f5"

    
    plt.scatter(x = positions[:, 0],
                y = positions[:, 1],
                s = 10,
                c = colors.tolist())
    plt.axis([-scale,
              scale,
              -scale,
              scale])
    plt.gca().set_aspect("equal", adjustable = "box")
    plt.pause(pause)\
   
    
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
    health_state = np.zeros(num_people)
    
    # a boolean vector that has True wherever a corresponding point in health_state
            # is vaccinated
    vaccinated = np.logical_and(probabilities > base_infection, 
                                probabilities < (base_vaccination + base_infection))
    
    # a boolean vector that has True wherever a corresponding point in health_state
            # is infected
    infect = probabilities < base_infection
    
    health_state[vaccinated] = 2
    health_state[infect] = 1
    
    return(health_state)


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
    
    # move people back to original position if outside
    people_pos_new[outside_box2] = people_pos[outside_box2]
    return(people_pos_new)

# function to infect people
 # params:
    # people_pos = the x and y coordinates of each point (2D array)
    # health_state = stores the health state of every point (1D array)
def Infect(people_pos,
           health_state,
           critical_distance,
           vaccine_effectiveness,
           susceptibility,
           recovered,
           reff,
           step):
    
    # create random number
    random_infect = np.random.uniform(low = 0,
                                      high = 1,
                                      size = num_people)
    
    
    # calculate Reff
    reff = calculateExactReff(health_state,
                                  people_pos,
                                  random_infect,
                                  vaccine_effectiveness,
                                  susceptibility,
                                  recovered,
                                  reff,
                                  critical_distance,
                                  step)

    # a boolean array with True where health_state = 1 and False otherwise
    infe = health_state == 1
    # position on the Cartesian plane of infected people
    infected_pos = people_pos[infe]
    # calculates euclidean distances between every single person to every other infected individual
    distance_to_infected = distance.cdist(people_pos,
                                          infected_pos,
                                          "euclidean")
    
    # boolean array with True if any point is close enough to get infected
    close_ind = distance_to_infected <= critical_distance
    # array with the number of infected people near each person
    close_to_infected = np.sum(close_ind, axis = 1) >= 1
    
    within_danger = close_to_infected | infe
    
    # a boolean array with True if not infected
    vaccine_lottery = np.logical_and(health_state == 2,
                                     random_infect < vaccine_effectiveness)
    within_danger[vaccine_lottery] = False
    
    # boolean array with True if immune
    resisted = np.logical_and(recovered,
                              random_infect < 0.5)
    within_danger[resisted] = False
    
    # boolean array with True if not susceptible
    not_susceptible = susceptibility < random_infect * 100 
    within_danger[not_susceptible] = False
    
    # infect the vulnerable population
    health_state[within_danger] = 1
    
    return health_state, reff


def updateRecovery(health_state,
                   time_since_infected,
                   recovery_time,
                   recovered):
    
    ### Vars:
        # infectec_vector: vector of 0s (uninf), 1s (inf), 2 (vaccinated)
        # time_since_infected: number of steps
        # recovery_time: how long before it's healed
        
    ### FO: here, you're looking for infected people, so we should
    ### name the vector with something like that
    ### perhaps we should change the name of health_state too?
    equals1 = health_state == 1
    time_since_infected[equals1] += 1
    
    ### it's good style to just use >= sign here
    ### we can talk about why
    make_recover = time_since_infected == recovery_time
    
    ### do you want to make them healthy? Perhaps
    ### we can make them immune?
    health_state[make_recover] = 0
    time_since_infected[make_recover] = 0
    recovered[make_recover] = True
    
    
    return health_state



def calculateExactReff(health_state,
                       people_pos,
                       random_infect,
                       vaccine_effectiveness,
                       susceptibility,
                       recovered,
                       reff,
                       critical_distance,
                       step):
    
    infe = health_state == 1
    inf_pos = people_pos[infe]
    
    vacc_danger = np.logical_and(health_state == 2,
                                 random_infect < vaccine_effectiveness)
    
    recov_danger = np.logical_and(recovered,
                                  random_infect < 0.5)
    
    
    suscep_danger = np.logical_and(health_state == 0,
                                   susceptibility < random_infect * 100)
    
    almost_danger = np.logical_or(vacc_danger, recov_danger)
    almost_danger = np.logical_or(almost_danger, suscep_danger)
    final_danger = np.logical_and(almost_danger, np.logical_not(infe))
    
    
    non_inf_pos = people_pos[final_danger]
    
    distance_to_infected = distance.cdist(non_inf_pos,
                                          inf_pos,
                                          "euclidean")
    close_ind = distance_to_infected <= critical_distance
    
    num_infected = np.sum(close_ind, axis = 0)
    #print("num_inf: " + str(np.size(num_infected)))
    
    # contains indices of all infected people in health_state
    indices_all_inf = np.where(infe)[0]
    #print("ind_all_inf: " + str(np.size(indices_all_inf)))
    
    # contains the indices of the infected people that ended up infecting others
    indices_secondary_inf = np.where(num_infected > 0)[0]
    #print("ind_second_inf: " + str(np.size(indices_secondary_inf)))
    
    # indices of the infected people whose Reff needs to be updated in reff
    indices_to_update = indices_all_inf[indices_secondary_inf]
    #print("ind_to_up: " + str(np.size(indices_to_update)))
    
    
    reff[indices_to_update, step] = num_infected[indices_secondary_inf]
    reff[num_people, step] = np.sum(num_infected)/np.size(infe)
    
    return reff


##############################################################################

# PARAMETERS 

# diffusion coefficient (km^2 per hour)
D = 9.0 * math.pi # 1.25

# time scale (days), so delt =  1 day
delt = 1.0 # 0.1

# number of people
num_people = 2000

scale = 11.0

# people positions (uniformly distributed)
# type np.random.uniform(-1, 1, [5, 2]) in the console
# to make sure you understand how to use np.random.uniform()
### FO: we now don't need this here since it's overwritten lower down
people_pos = np.random.uniform(-(scale - 1),
                               (scale - 1),
                               [num_people, 2])


# calculate steps based on sim
# made into an integer (no decimals) because
# for loops need to use integers
num_steps = 100


# set initial rate of infection
    # fraction of initial points that will be infected
base_infection = 0.1

# initial rate of vaccinated people
base_vaccination = 0.8

# create health_state for t=0 of simulation
# look at the function!
health_state = CreateInfectedVector(num_people,
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
# this is to have a dynamic range; youngest would have ~50% and 
    # oldest would have ~100% susceptibility
susceptibility = (ages * 0.56) + 50


vaccine_effectiveness = 0.8


# critical distance for infection
critical_distance = 0.2
recovery_time = 14

# determine parameters you want to change!
vaccine_eff = np.arange(start = 0,
                        stop = 1.1,
                        step = 0.1)


base_vacc = np.arange(start = 0,
                            stop = 1.1,
                            step = 0.1)

# how many parameters do you have?
data = np.zeros((len(base_vacc), 2))

# store them all in the first column
data[:, 0] = base_vacc

# repeat them as many times as you want
data = np.repeat(data,
                 repeats = 5,
                 axis = 0)

# calculate total number of sims
num_sims = np.shape(data)[0]

final_reff = np.zeros(num_sims)


##############################################################################

# RUN SIMULATION

t = time.time()


# this holds the number if infected people after each step within a simulation
for sim in range(num_sims):
    base_vaccination = data[sim, 0]

    time_since_infected = np.zeros(num_people)

    # declare new arrays for a new experiment:
    
    # (1) recovered from disease
    recovered = np.full(num_people, False)

    # (2) initial positions
    people_pos = np.random.uniform(low = -(scale - 1),
                                   high = (scale - 1),
                                   size = [num_people, 2])
 
    # (3) create infected vector
    health_state = CreateInfectedVector(num_people,
                                           base_infection,
                                           base_vaccination)
    # (4) create the reff array
    reff = np.zeros((num_people+1, num_steps))

    # loop through steps of simulation!
    for step in range(num_steps):

        # move!
        people_pos = MovePeople(people_pos,
                                num_people,
                                D,
                                delt,
                                scale)
        # infect (and calculate reff within infect)!
        health_state, reff = Infect(people_pos,
                                          health_state,
                                          critical_distance,
                                          vaccine_effectiveness,
                                          susceptibility,
                                          recovered,
                                          reff,
                                          step)

        # recover!
        health_state = updateRecovery(health_state,
                                         time_since_infected,
                                         recovery_time,
                                         recovered)
        # PlotSim(people_pos, 
        #         health_state, 
        #         scale, 
        #         pause = 0.000001)
        

    num_infected = np.sum(health_state == 1)
    percent_infected = (num_infected / num_people) * 100
    data[sim, 1] = percent_infected
    
    mean = np.mean(reff[num_people, :])
    final_reff[sim] = mean


print("TIME = " + str(time.time() - t) + " seconds")
print(data)

protective_effect = np.mean(data[0:5, 1]) - data[:, 1]
data = np.insert(data, 2, protective_effect, axis = 1)
data = np.insert(data, 3, final_reff, axis = 1)

# save data as .csv
np.savetxt(fname = "/Users/sirikonanoor/Documents/Polygence/csvfiles/vaccine_compliance_0.8.csv",
          X = data,
          delimiter = ",")