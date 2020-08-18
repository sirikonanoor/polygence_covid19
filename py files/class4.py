#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Jun 16 20:35:07 2020

@author: fabianortega
"""

import numpy as np
import time

# create randomly-distributed data!
size_data = int(1e7)
data = np.random.randn(size_data)

# Time appending to a list!
my_list = []
now = time.time()
for datum in data:
    my_list.append(datum)
list_time = time.time() - now
print(list_time)