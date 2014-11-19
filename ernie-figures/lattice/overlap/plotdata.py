import numpy as np
import matplotlib.pyplot as plt


# get data
data = np.loadtxt("pico.dat")
plt.rc('text', usetex=True)
plt.rc('font', family='serif')
figure = plt.figure(figsize=(5,5))
ax = figure.add_subplot(111)
x = [ i*10 for i in range(len(data[:,2]))]
l1 = ax.plot(x,data[:,1],"r-",label = r'\textit{Position} ')
ax2 = ax.twinx()
l2 = ax2.plot(x,data[:,3],"b-",label = r'\textit{Size}')
#ax.set_ylim([0,14])
ax.set_xlabel(r'\textit{Picomotor Movement}',fontsize = 16)
ax.set_ylabel(r'Atom cloud position (\textit{Pixel})',fontsize = 16)
ax2.set_ylabel(r'Atom cloud size (\mu m)',fontsize = 16)
#plt.title(r"Evaporation Trajectory",fontsize=20)
#plt.legend(loc=0)
lns = l1+l2
labs = [l.get_label() for l in lns]
ax.legend(lns, labs, loc=0)
plt.savefig('pico.pdf')
#plt.show()
