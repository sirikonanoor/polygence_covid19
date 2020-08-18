import math
import numpy as np
import matplotlib.pyplot as plt

# you will want to import this:
from scipy.spatial import distance

##############################################################################

# FUNCTIONS

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

# function to create initial vector of infected people
def CreateInfectedVector(num_people, base_infection):
    
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
    infected_vector = probabilities < base_infection
    return(infected_vector)

# plot simulation
def PlotSim(positions, infected, scale, pause):
    colors = ["red" if inf else "black" for inf in infected]
    plt.scatter(x = positions[:, 0],
                y = positions[:, 1],
                s = 10,
                c = colors)
    plt.axis([-scale, scale, -scale, scale])
    plt.gca().set_aspect("equal", adjustable = "box")
    plt.pause(pause)

# infect people (HOMEWORK!)
def Infect(people_pos, infected_vector, critical_distance):
    
    # modify infected_vector
    
    # look at scipy.spatial.distance.cdist function
    # https://docs.scipy.org/doc/scipy/reference/generated/scipy.spatial.distance.cdist.html
    # learn how to use it first!
    
    distances = distance.cdist(people_pos, people_pos, 'euclidean')
    #print (distances)
    
    
    
    #new_inf_vector = np.zeros((num_people, 1))
    #num = 0
    new_inf_vector = infected_vector
    
    for r in range(distances.shape[0]):
        for c in range(distances.shape[1]):
            if(r != c):
                if(distances[r][c] < critical_distance and (infected_vector[r] == 1 or
                                                            infected_vector[c] == 1)):
                    new_inf_vector[r] = 1
                    new_inf_vector[c] = 1
    
    # what I did was to get the distance from the infected points
    # to all other points. If they were below your critical distance
    # then set them to be infected, otherwise, leave alone!
    
    # good luck!
    
    return(new_inf_vector)

##############################################################################

# PARAMETERS 

# diffusion coefficient (km^2 per hour)
D = 1.25

# time scale (hours), so 6 minutes
delt = 0.1

# number of people (try changing this!)
num_people = 500

# people positions (uniformly distributed)
# type np.random.uniform(-1, 1, [5, 2]) in the console
# to make sure you understand how to use np.random.uniform()
people_pos = np.random.uniform(-10, 10, [num_people, 2])

# total number of hours for simulation
# since delt = 0.1, this is equivalent to
# 100 iterations of for loop (shown below)
total_sim_time = 5.0

# calculate steps based on sim
# made into an integer (no decimals) because
# for loops need to use integers
num_steps = int(total_sim_time / delt)

# size of map (in km)
# we are simulating SF, which is ~121 km^2
scale = 11

# set initial rate of infection
# fraction of initial points that will be infected
# try playing around with this too!
base_infection = 0.1

# create infected_vector for t=0 of simulation
# look at the function!
infected_vector = CreateInfectedVector(num_people, base_infection)

# critical distance for infection
# play with this to make sure you understand it!
critical_distance = 0.1

# plot simulation at t = 0
# aka what the simulation looks like
# before people start moving
PlotSim(people_pos, infected_vector, scale, pause = 2)

##############################################################################

# RUN SIMULATION

# remember that every step is worth 0.1 hours (set by delt)

for step in range(num_steps):
    
    # move your people once per step
    # hopefully this function makes sense!
    people_pos = MovePeople(people_pos, num_people, D, delt)
    
    # infect people 
    # homework is to write this function!
    infected_vector = Infect(people_pos, infected_vector, critical_distance)
    
    # plot each step of sim
    # this just groups all the plotting code
    PlotSim(people_pos, infected_vector, scale, pause = 0.01)