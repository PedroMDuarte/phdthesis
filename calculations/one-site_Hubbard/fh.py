import numpy as np

        
import matplotlib.pyplot as plt
import matplotlib
from matplotlib import rc
rc('font',**{'family':'serif'})
      
      
if __name__=="__main__":
    
    figure = plt.figure(figsize=(5,4.))
    gs = matplotlib.gridspec.GridSpec( 1,1) 
    figure.suptitle('')
    ax = plt.subplot( gs[0,0] )

    c=['red','green','blue','black']

    U = 1.
    Temperature = [0.5,0.1,0.05]
    for i,T in enumerate(Temperature):
        beta = 1 / T

        mu = np.linspace(0.,2.5,60)
        nocc = 2*( np.exp(beta*mu) + np.exp( -beta*U+ 2*beta*mu)) / \
               (1+2*np.exp(beta*mu) + np.exp( -beta*U+ 2*beta*mu) )
        ax.plot( mu, nocc, '-', c=c[i], lw=1.5, label='$T=$%.2f'%T) 


    ax.grid()
    ax.set_xlabel('$\mu$')
    ax.set_ylabel(r'$\langle n \rangle$')
    ax.legend(loc='best',numpoints=1,\
         prop={'size':10}, \
         handlelength=1.1,handletextpad=0.5)
    gs.tight_layout(figure, rect=[0,0.0,1.0,0.96])
    outfile = '0t_occupation.png'
    figure.savefig(outfile, dpi=250)
  
        
        
  
    
