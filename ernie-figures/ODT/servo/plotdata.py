import numpy as np
import matplotlib.pyplot as plt


# get data
data = np.loadtxt("data.dat")
plt.rc('text', usetex=True)
plt.rc('font', family='serif')
figure = plt.figure(figsize=(5,5))
ax = figure.add_subplot(111)
ax.plot(data[::3,2],data[::3,3],".",label = "PD Sum")
ax.plot(data[::3,0],data[::3,1],"-",label = "High Power PD")
ax.set_ylim([0,14])
plt.xlabel(r'\textit{Time} (sec)',fontsize = 16)
plt.ylabel(r'\textit{Voltage} (V)',fontsize = 16)
plt.title(r"Evaporation Trajectory",fontsize=20)
plt.legend(loc=0)
# Make room for the ridiculously large title.
plt.savefig('evap.pdf')
#plt.show()
