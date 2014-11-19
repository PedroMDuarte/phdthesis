import numpy as np
import matplotlib.pyplot as plt


# get data
data = np.loadtxt("131209.dat")
plt.rc('text', usetex=True)
plt.rc('font', family='serif')
figure = plt.figure(figsize=(5,5))
ax = figure.add_subplot(111)
ax.plot(data[:,1],data[:,0],"*",label = "Measured data")
ax.plot(data[:,1],data[:,0],"-",label = "Fitted line")
plt.xlabel(r'\textit{Dipole trap intensity} (a.u.)',fontsize = 16)
plt.ylabel(r'\textit{Summed Photo Diode Voltage} (V)',fontsize = 16)
plt.title(r"Calibration of ODT servo",fontsize=20)
plt.legend(loc=0)
# Make room for the ridiculously large title.

plt.savefig('odtcalib.jpg')
#plt.show()
