#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Jul 25 23:51:41 2020

@author: sirikonanoor
"""

import numpy as np
from scipy.spatial import distance


def calculateExactReff(health_state,
                       people_pos,
                       random_infect,
                       vaccine_effectiveness,
                       susceptibility,
                       reff,
                       critical_distance,
                       step):
    
    infe = health_state == 1
    inf_pos = people_pos[infe]
    
    vacc_danger = np.logical_and(health_state == 2,
                                 random_infect < vaccine_effectiveness)
    
    recov_danger = np.logical_and(health_state == 4,
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