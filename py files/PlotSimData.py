#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Jun 24 13:50:36 2020

@author: sirikonanoor
"""
import numpy as np
import csv
import matplotlib
import matplotlib.pyplot as plt
# matplotlib.use('Agg')


with open('/Users/sirikonanoor/Documents/Polygence/sim_data.csv', 'r') as f:
    sheetreader = list(csv.reader(f))
    xaxis = np.arange(start = 0.0,
                      stop  = 1.1,
                      step = 0.1)
    yaxis = [i[0] for i in sheetreader]
    
    plt.figure()
    plt.title("Percent Infected over Vaccine Effectivity")
    plt.xlabel("Vaccine Effectivity")
    plt.ylabel("Percent Infected")
    
    plt.plot(xaxis, yaxis)
    plt.savefig('/Users/sirikonanoor/Documents/Polygence/sim_fig.png')