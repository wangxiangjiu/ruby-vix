#get_ipython().magic('load_ext autoreload')
#get_ipython().magic('autoreload 2')
# import matplotlib
# import matplotlib.pyplot as plt
#get_ipython().magic('matplotlib inline')
import sys
import math
import numpy as np
import pandas as pd
import os
import time
# import pickle
import random
from scipy.stats import norm
# import argparse
# import shlex
# import re
from scipy import interpolate
# import shutil
# import sklearn
# import sklearn.metrics
import torch
from torch.autograd import Variable
import torch.nn as nn
import torch.nn.functional as F
import torch.nn.parallel
import torchvision
import torchvision.transforms as transforms
import json


from torch.utils.data import Dataset, DataLoader
from torchvision import transforms, utils


# load custom functions
#sys.path.append('/home/pacrim/git/pacrim/lib/')
# from pacrim_utils import *

class Net(nn.Module):

    def __init__(self):
        super(Net, self).__init__()
        
        self.fc1 = nn.Linear(4, 20)
        self.fc2 = nn.Linear(20, 20)
        self.fc3 = nn.Linear(20,1)
        self.fc4 = nn.Linear(20,1)
    
    def forward(self, x):
        x = F.sigmoid(self.fc1(x))
        x = F.sigmoid(self.fc2(x))
        
        y1 = self.fc3(x)
        y2 = F.relu(self.fc4(x))+0.1
    
        x = torch.cat((y1,y2), dim=1)            
        return x

model = Net().cuda()

checkpoint = torch.load('./model_best.pth.tar')
best_prec = checkpoint['best_prec']
model.load_state_dict(checkpoint['state_dict'])

def predict_return_stat(model, DTE, OTM, VIX, FV):
    
    
    """
    input:  model 
            DTE - time to expiration in days
            OTM - out-of-the-money in percentage
            VIX - current VIX
            FV -  VIX after one week
    """
    # preprocessing
    X = np.array([DTE/250, OTM/20, (VIX-17.615)/5.672911, np.log(FV/VIX)]).astype(np.float32)
    X = X.reshape(1,4)
    
    y = model(Variable(torch.FloatTensor(X).cuda()))
    y = y.data.cpu().numpy()
    return y  
    
def parse_json():
    json_data = sys.argv[1]
    data = json.loads(json_data)
    dte = data["dte"]
    otm = data["otm"]
    vix = data["vix"]
    fv = data["fv"]
    return dte, otm, vix, fv

dte, otm, vix, fv = parse_json()

print(predict_return_stat(model, dte, otm, vix, fv))

print("uhh?")