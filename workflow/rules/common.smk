from snakemake.utils import validate
import pandas as pd
import os
import glob
import yaml

##### load config and sample sheets #####
configfile: "config/config.yaml" 

analysisdir = config['analysis']
rawdir = config['unaligned']
smpl =  [os.path.basename(file).split('.')[0].split('_R1')[0] for file in glob.glob(rawdir + '/*') if 'R1' in file]
samples = [s.replace('Sample_', '') for s in smpl]
os.chdir(analysisdir)
partition=config['medium']['partition']
