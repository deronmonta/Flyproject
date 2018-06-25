import scipy.io as spio
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
file = spio.loadmat(r'C:\Users\FurryMonster Yang\Dropbox\MAT_files\different desiccation time\12_hr\0110_4wiped_desiccants_12hrs-1_uncompressed-4_processed.avi')

print(file)
for key in file:
    print(key)
wholepos = file['wholepos']

#fig, ax = plt.subplots()
fig, ax = plt.subplots()
ax.plot(wholepos[:,0],wholepos[:,1] )

plt.show()