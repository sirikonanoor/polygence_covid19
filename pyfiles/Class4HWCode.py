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
import csv

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
    #plt.ylim(0, 100)
    plt.show()
    plt.pause(3)


# this method draws a graph of the number of infected people at the end of 
    # num_sims number of sims
 # params:
    # counts = array that contains num of infected people at the end of each sim (1D array)
def PlotOverSimInfRate(counts, vaccine_eff):
    plt.plot(vaccine_eff, counts)
    plt.ylabel("Percent of Infected People")
    plt.xlabel("Vaccination Effectivity")
    #plt.xlim(0, 1)
    #plt.xscale(0.1)
    #plt.ylim(0, 100)
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
    outside_box2 = np.logical_or(outside_box[:,0],
                                 outside_box[:,1])
    
    people_pos_new[outside_box2] = people_pos[outside_box2]
    return(people_pos_new)

# function to infect people
 # params:
    # people_pos = the x and y coordinates of each point (2D array)
    # infected_vector = stores the health state of every point (1D array)
def Infect(people_pos,
           infected_vector,
           critical_distance,
           vaccine_effectivity,
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
                                     random_infect < vaccine_effectivity)
    within_danger[vaccine_lottery] = False
    
    ### FO: does this mean there is a 50% chance of just not becoming inf?
    
    resisted = np.logical_and(recovered,
                              random_infect < 0.5)
    within_danger[resisted] = False
    
    # check susceptibility
    not_susceptible = susceptibility < random_infect*100
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

def PlotBoxPlots(same_parameter_repeat):
    fig = plt.figure(1, figsize=(9, 6))

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
people_pos = np.random.uniform(-(scale - 1), (scale - 1), [num_people, 2])

# total number of hours for simulation
# since delt = 0.1, this is equivalent to
# 100 iterations of for loop (shown below)
total_sim_time = 15.0

# calculate steps based on sim
# made into an integer (no decimals) because
# for loops need to use integers
num_steps = int(total_sim_time / delt)
# number of simulations to run
num_sims = 1 # 6
# number of times to repeat a sim with the same parameters
num_repeats = 10

# set initial rate of infection
# fraction of initial points that will be infected
# try playing around with this too!
base_infection = 0.3

# initial rate of vaccinated people
base_vaccination = 0.0

# create infected_vector for t=0 of simulation
# look at the function!
infected_vector = CreateInfectedVector(num_people,
                                       base_infection,
                                       base_vaccination)

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
susceptibility = ages * 9999


# critical distance for infection
critical_distance = 0.1
# critical_distance = ages/300
# time till recovery after infection
recovery_time = 99999

vaccine_eff = []
# effectivity of the vaccine as a percentage
# describes the probability of being infected after being vaccinated
vaccine_effectivity = 1.0

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
    
    recovered = np.full(num_people, False)
    
    ### FO: this works well
    people_pos = np.random.uniform(low = -(scale-1),
                                   high = (scale-1),
                                   size = [num_people, 2])
    infected_vector = CreateInfectedVector(num_people,
                                           base_infection,
                                           base_vaccination)
    
    
    # counts the number of steps it has been since a point is infected
    time_since_infected = np.zeros(num_people)

    # this holds the number if infected people after each step within a simulation
    per_sim = []
    
    
    for step in range(num_steps):
        
        # move your people once per step
        # hopefully this function makes sense!
        people_pos = MovePeople(people_pos, num_people, D, delt, scale)
            
        # infect people 
        # homework is to write this function!
        infected_vector = Infect(people_pos,
                                 infected_vector,
                                 critical_distance,
                                 vaccine_effectivity,
                                 susceptibility)
            
        nums_of_1 = np.count_nonzero(infected_vector == 1)
        
        ### FO: I would define: nums_of_1/num_people
        ### percent_infected = (nums_of_1 / num_people) * 100
        ### per_sim.append(percent_infected)
        per_sim.append((nums_of_1/num_people)*100)
        
        ### nice job calling this function
        ### need to add the Recovered vector here too...
        infected_vector = updateRecovery(infected_vector,
                                         time_since_infected,
                                         recovery_time,
                                         recovered)
        
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
# xaxis = vaccine_eff
# yaxis = over_sim

# py.title("% infected against percent infected")
# py.xlabel('Vaccination Effectivity')
# py.ylabel('Percent of Infected People')

# py.plot(xaxis, yaxis)
# py.savefig('/Users/sirikonanoor/Documents/Polygence/simfigs.png')
# np.savetxt("sim_data.csv", over_sim, delimiter = ",")

print(time.time() - t)









"""### FOR CALCULATING CHANGE IN % INFECTED AT EACH STEP OVER THE MULTIPLE SIMULATIONS
per_step_comparison = np.zeros((num_sims, num_steps))
for sim in range(num_sims):
    
    ### FO: this means you're starting with eff of 0.2 ?
    # vaccine_effectivity += 0.1
    
    ### FO: save vaccine values
    vaccine_eff.append(vaccine_effectivity)
    
    recovered = np.full(num_people, False)
    
    ### FO: this works well
    people_pos = np.random.uniform(low = -(scale-1),
                                   high = (scale-1),
                                   size = [num_people, 2])
    infected_vector = CreateInfectedVector(num_people,
                                           base_infection,
                                           base_vaccination)
    
    
    # counts the number of steps it has been since a point is infected
    time_since_infected = np.zeros(num_people)
    
    for step in range(num_steps):
        
        # move your people once per step
        # hopefully this function makes sense!
        people_pos = MovePeople(people_pos, num_people, D, delt, scale)
            
        # infect people 
        # homework is to write this function!
        infected_vector = Infect(people_pos,
                                 infected_vector,
                                 critical_distance,
                                 vaccine_effectivity,
                                 susceptibility)
        
        
        nums_of_1 = np.count_nonzero(infected_vector == 1)
        percent_infected = (nums_of_1 / num_people) * 100
        per_step_comparison[sim][step] = (nums_of_1/num_people)*100
        
        
        ### nice job calling this function
        ### need to add the Recovered vector here too...
        infected_vector = updateRecovery(infected_vector,
                                         time_since_infected,
                                         recovery_time,
                                         recovered)
    
    vaccine_effectivity += 0.1

# PlotBoxPlots(per_step_comparison)
print(per_step_comparison)
np.savetxt("sim_data.csv", per_step_comparison, delimiter = ",")"""
 





"""import time
t = time.time()
### FOR REPEATING WITH THE SAME PARAMETERS A FEW TIMES
same_parameter_repeat = np.zeros((num_sims, num_repeats))

for sim in range(num_sims):
    
    ### FO: save vaccine values
    vaccine_eff.append(vaccine_effectivity)
    
    
    # this holds the number if infected people after each step within a simulation
    
    
    for repeat in range(4):
        
        
        # declaring new arrays for a new experiment
        recovered = np.full(num_people, False)
        
        people_pos = np.random.uniform(low = -(scale-1),
                                       high = (scale-1),
                                       size = [num_people, 2])
        
        infected_vector = CreateInfectedVector(num_people,
                                               base_infection,
                                               base_vaccination)
        
        
        # counts the number of steps it has been since a point is infected
        time_since_infected = np.zeros(num_people)
    
        for step in range(num_steps):
            
            # move your people once per step
            # hopefully this function makes sense!
            people_pos = MovePeople(people_pos, num_people, D, delt, scale)
                
            # infect people 
            # homework is to write this function!
            infected_vector = Infect(people_pos,
                                     infected_vector,
                                     critical_distance,
                                     vaccine_effectivity,
                                     susceptibility)
            
            
            ### nice job calling this function
            ### need to add the Recovered vector here too...
            infected_vector = updateRecovery(infected_vector,
                                             time_since_infected,
                                             recovery_time,
                                             recovered)
            
            
            # if(repeat == 0):
                # PlotSim(people_pos, infected_vector, scale, pause = 0.000001)
        
        nums_of_1 = np.count_nonzero(infected_vector == 1)
        percent_infected = (nums_of_1 / num_people) * 100
        same_parameter_repeat[sim][repeat] = (nums_of_1/num_people)*100
    
    vaccine_effectivity += 0.1
    
PlotBoxPlots(same_parameter_repeat)
print("TIME = " + str(time.time() - t))"""






""" 
#1) Base Infection: Critical distance = 0.1, 30% of popuplation is infected
#2) Base Infection with Immunity: critdist = 0.1, 30% infected and 30% vaccinated, vaccine eff = 1.0
#3) Infection with varying suceptibility: all the same params as above, ages are defined and susceptibility = ages*0.15
#4) Infection with vaccine_eff of 0.5, susceptibility defined as in #1 and 2
#5) Combining #3 and #4
#6) 

"""






"""


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
    plt.xlabel("Vaccination Effectivity")
    plt.show()
    
    
    

def PlotBoxPlots(same_parameter_repeat):
    fig = plt.figure(1, figsize=(9, 6))

    # Create an axes instance
    ax = fig.add_subplot(111)
    
    # Create the boxplot
    bp = ax.boxplot(same_parameter_repeat)
    
    # Save the figure
    # fig.savefig('fig1.png', bbox_inches='tight')
    
    """

