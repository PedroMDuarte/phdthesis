import numpy as np
import matplotlib.pyplot as plt


# get data
data = np.loadtxt("pico.dat")
plt.rc('text', usetex=True)
plt.rc('font', family='serif')
figure = plt.figure(figsize=(6.5,4.4))
ax = figure.add_subplot(111)
x = [ i*10 for i in range(len(data[:,2]))]
l1 = ax.plot(x,data[:,1],"r-o",label = r'$\mathrm{Position}$')
ax2 = ax.twinx()
l2 = ax2.plot(x,data[:,3],"b-o",label = r'$\mathrm{Size}$')
#ax.set_ylim([0,14])
ax.set_xlabel(r'$\mathrm{Picomotor\ step}$',fontsize = 13)
ax.set_ylabel(r'$\mathrm{cloud\ position\ (pixel)}$',fontsize = 13, color='red', labelpad=9)
ax2.set_ylabel(r'$\mathrm{cloud\ size\ }(\mu\mathrm{m})$',fontsize = 13, color='blue', labelpad=9.)
#plt.title(r"Evaporation Trajectory",fontsize=20)
#plt.legend(loc=0)
lns = l1+l2
labs = [l.get_label() for l in lns]
ax.legend(lns, labs, loc=0)
figure.tight_layout()
plt.savefig('pico.png', dpi=300)
#plt.show()
