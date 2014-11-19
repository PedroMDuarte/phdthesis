from math import *
import matplotlib.pyplot as plt
import matplotlib as mpl
import numpy as np
#from matplotlib import rc
#rc('font',**{'family':'serif'})
plt.rc('text', usetex=True)
plt.rc('font', family='serif')


def gaus(x):
	return exp(-x**2)

fig = plt.figure(figsize=(3.5,3.))
mpl.rcParams["axes.linewidth"]=2
data = np.loadtxt("testdata.txt")
x = data[:,0]
y = data[:,1]
yy = data[:,2]
ydata = data[:,3]
a = fig.add_subplot(1,1,1)
a.set_xlabel("Radius")
a.set_ylabel("Column Density")
a.plot(x,y,linewidth=8,color="red",alpha=0.8)
a.plot(x,yy,linewidth=4,color="blue",alpha=0.8)

a.set_ylim([0,140])
#a.plot(x,ydata,linewidth=2,color="black",alpha=0.5)
plt.legend(("Gaussian","Mott"),prop={'size':10})
plt.setp(a.get_xticklabels(),visible=False)
plt.setp(a.get_yticklabels(),visible=False)
plt.savefig("example1.pdf", dpi=200)

plt.clf()

x2d = [ i*1.0/30 for i in range(0,100)]
y2d = [ gaus(i) for i in x2d]
x2d = [i/3.5*90 for i in x2d]
yy2d = [ i if i<y2d[20] else y2d[20] for i in y2d]
a2d = fig.add_subplot(1,1,1)
a2d.set_ylabel("3D Density")
a2d.set_xlabel("Radius")
a2d.plot(x2d,y2d,linewidth=8,color="red",alpha = 0.8)
a2d.plot(x2d,yy2d,linewidth=4,color="blue",alpha = 0.8)
a2d.set_ylim([0,1.1])
plt.setp(a2d.get_xticklabels(),visible=False)
plt.setp(a2d.get_yticklabels(),visible=False)
plt.legend(("Gaussian","Mott"),prop={'size':10})
#plt.show()
plt.savefig("example2.pdf", dpi=200)
