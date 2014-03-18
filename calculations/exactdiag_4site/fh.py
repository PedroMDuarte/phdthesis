import numpy as np

class lattice():
    """Contains functions to help out calculate matrices
       in the Fermi-Hubbard model"""
    def __init__(self, xs,ys,zs):
        self.x, self.y, self.z = np.mgrid[ 0:xs, 0:ys, 0:zs] 
        self.xs = xs
        self.ys = ys
        self.zs = zs
   
    def show(self,spins):
        for i in np.ravel(spins):
            print "%d "%i,
        print

    def state(self,m):
        # Each site can have 4 possible configurations, we have 
        # labeled them as follows:
        # 
        #  0  = vacuum
        #  1  = spin up
        #  2  = spin down
        #  3  = doubly occupied
        # 
        spins = np.zeros_like( self.x)
        i = 0
        end = False
        while m > 0:
            if  i>=spins.size:
                end =True
                break 
            spins.flat[i] =  (m%4)
            m = m /4
            i = i +1
        if end:
            return None
        else:
            return spins
 
    def sector(self):
        # Calculates the spin sector for the current state
        s = 0
        for i in self.spins.flat:
            if i == 0 : s = s+0
            elif i == 1 : s = s+1
            elif i == 2 : s = s-1
            elif i == 3 : s = s+0
        return s

    def filling(self):
        # Calculates the fillign for the current state
        f = 0
        for i in self.spins.flat:
            if i == 0 : f = f+0
            elif i == 1 : f = f+1
            elif i == 2 : f = f+1
            elif i == 3 : f = f+2
        return f
        
  
    def defstates(self):
        '''This function calculates the half filling states of the 
           Fermi-Hubbard model in a 3D lattice'''
        end = False
        n = 0
        self.states = {}
        while n < 300:
            self.spins = self.state(n)
            
            # The condition on this specifies only HALF-FILLING states 
            if self.spins is not None and self.filling() == self.spins.size:
                sec = self.sector()
                if sec in self.states.keys():
                    self.states[ sec].append(self.spins) 
                else:
                    self.states[ sec]=[self.spins] 
            n = n+1
        for k in self.states.keys():
            print "Sector %d, %d states:"%(k,len(self.states[k]))
            for spins in self.states[k]:
                self.show(spins)

    def nearest(self):
        '''This function makes a list of the nearest neighbor 
           pairs in the lattice'''
        print "\nNearest neighbors:"
       
        sites = [] 
        for i in range(self.x.size):
            sites.append( (self.x.flat[i], self.y.flat[i], self.z.flat[i], i))
        neighbors = []
        for i,s1 in enumerate(sites):
           for j,s2 in enumerate(sites): 
               if j > i: 
                   d2 = (s1[0]-s2[0])**2 + (s1[1]-s2[1])**2 + (s1[2]-s2[2])**2 
                   print s1,"--",s2," = ",d2
                   if d2 == 1: 
                       neighbors.append( (s1[3],s2[3]))
        print "Neighbor list: "
        print neighbors
        self.neighbors = neighbors
    
    def kinetic0(self):
        '''This function calculates the kinetic energy matrix
           in the spin=0 sector'''

        # I AM NOT SURE THAT THE connected and tsign
        # LISTS ARE CORRENT !!! CAUTION.
        connected = [(0,3,1,2),\
                     (0,3,2,1),\
                     (3,0,1,2),\
                     (3,0,2,1),\
                     (1,2,0,3),\
                     (1,2,3,0),\
                     (2,1,0,3),\
                     (2,1,3,0),\
                     \
                     (0,1,1,0),\
                     (0,2,2,0),\
                     (1,0,0,1),\
                     (2,0,0,2),\
                     \
                     
                    ]
        tsign = [ 1, -1, 1, -1, 1, 1, -1, -1,  -1,-1,1,1  ]
        print
        msize = len(self.states[0])
        kinetic = np.zeros((msize,msize))
        for i,s1 in enumerate(self.states[0]):
            for j,s2 in enumerate(self.states[0]):
                # Need to generalize this to an arbitrary number of sites 
                    #annihilate( 0, 'up', s2)
                    #annihilate( 0, 'down', s2)
                    #annihilate( 1, 'up', s2)
                    #annihilate( 1, 'down', s2)
                    #annihilate( 2, 'up', s2)
                    #annihilate( 2, 'down', s2)
                    #annihilate( 3, 'up', s2)
                    #annihilate( 3, 'down', s2)
                    #print 
                    #create( 0, 'up', s2)
                    #create( 0, 'down', s2)
                    #create( 1, 'up', s2)
                    #create( 1, 'down', s2)
                    #create( 2, 'up', s2)
                    #create( 2, 'down', s2)
                    #create( 3, 'up', s2)
                    #create( 3, 'down', s2)
                t = 0.
                for n in self.neighbors:
                    PRINT = False
                    for spin in ['up','down']:
                        if PRINT:
                            print 
                            print "<", np.ravel(s1)," | K | ", np.ravel(s2),">"

                        signA, stateA = annihilate( n[0], spin, s2) 
                        signC, stateC = create(n[1], spin, stateA)
                        if PRINT: 
                            print "annihilate %d,%5s"%(n[0],spin)," -->",stateA
                            print "    create %d,%5s"%(n[1],spin)," -->",stateC
                        if np.array_equal(stateC,np.ravel(s1)):
                            if PRINT: print " tmatrix --> % d" % (signA*signC )
                            t+= signA*signC

                        signA, stateA = annihilate( n[1], spin, s2) 
                        signC, stateC = create(n[0], spin, stateA)
                        if PRINT: 
                            print "annihilate %d,%5s"%(n[1],spin)," -->",stateA
                            print "    create %d,%5s"%(n[0],spin)," -->",stateC
                        if np.array_equal(stateC,np.ravel(s1)):
                            if PRINT: print " tmatrix --> % d" % (signA*signC )
                            t+= signA*signC
 
                kinetic[i,j] = t 

                #    # Here we have two sites with two states, we will write them
                #    # in a tuple as:
                #    d = ( (s1.flat[n[0]], s1.flat[n[1]]), (s2.flat[n[0]], s2.flat[n[1]]))
                #    if OUT:
                #        print "Neighbors (#1,#2) = (%d,%d)" % (n[0],n[1]) 
                #        print "States = ",d, " --> ",
                #    c = (s1.flat[n[0]], s1.flat[n[1]], s2.flat[n[0]], s2.flat[n[1]])
                #    if False:
                #      print "States %d,%d"%(i,j),"Neighbor pair ",n,\
                #             "  --> %d,%d and %d,%d"%c,
		#    if c in connected:
                #        kinetic[i,j] = kinetic[i,j] - tsign[ connected.index(c) ] 
                #        if OUT: print "-t" 
                #    else:
                #        if OUT: print 
        print "\nKinetic energy matrix: ",kinetic.shape
        print kinetic 
        self.kinetic = kinetic
 
    def interaction0(self):
        '''This fuction calculates the interaction energy matrix
           in the spin=0 sector'''
        print
        msize = len(self.states[0])
        inter = np.zeros((msize,msize))
        # The basis we have chose is of number states,
        # so the interaction energy is diagonal
        for i,s1 in enumerate(self.states[0]):
            for site in s1.flat:
                if site == 3: # 3=double occupancy
                    inter[i,i] = inter[i,i] + 1
        print "\nInteraction energy matrix:i ",inter.shape
        print inter
        self.inter = inter

    def diagonal0(self):
        '''This fuction calculates a diagonal matrix
           in the spin=0 sector'''
        print
        msize = len(self.states[0])
        diag = np.zeros((msize,msize))
        # The basis we have chose is of number states,
        # so the interaction energy is diagonal
        for i,s1 in enumerate(self.states[0]):
            for site in s1.flat:
                diag[i,i] = 1.0
        self.diag = diag

def annihilate( i, spin, state):
    # The order for the creation operators is lower site number
    # to the left,  and then spin-up to the left
    s = np.ravel(state)
    out = np.copy(s)
    samespin = {'up':1, 'down':2} 
    flipspin = {'up':2, 'down':1} 
    
    ncommute = 0. 
    for j in range(i):
        if s[j] == 3: ncommute +=2
        if s[j] == 1 or s[j] == 2: ncommute+=1 
    sign = (-1)**ncommute
    
    if s[i] == 0: 
        out = np.zeros_like(s) 

    if s[i] == flipspin[spin]:
        out = np.zeros_like(s) 

    if s[i] == 3: 
        out[i] = flipspin[spin] 
        if spin == 'up': sign*= 1
        if spin == 'down': sign*=-1

    if s[i] == samespin[spin]:
        out[i] = 0 

    #print s, ", annihilate %d,%5s"%(i,spin)," --> %+d"%sign, out
    return sign, out
    
def create( i, spin, state):
    # The order for the creation operators is lower site number
    # to the left,  and then spin-up to the left
    s = np.ravel(state)
    out = np.copy(s)
    samespin = {'up':1, 'down':2} 
    flipspin = {'up':2, 'down':1} 
    
    ncommute = 0. 
    for j in range(i):
        if s[j] == 3: ncommute +=2
        if s[j] == 1 or s[j] == 2: ncommute+=1 
    sign = (-1)**ncommute
    
    if s[i] == 0: 
        out[i] = samespin[spin]

    if s[i] == flipspin[spin]:
        out[i] = 3 
        if spin == 'up': sign*=1
        if spin == 'down': sign*=-1

    if s[i] == 3: 
        out = np.zeros_like(s) 

    if s[i] == samespin[spin]:
        out = np.zeros_like(s) 

    #print s, ", create %d,%5s"%(i,spin)," --> %+d"%sign, out
    return sign, out

def puretext(state):
    out = r'|'
    for j,i in enumerate(np.ravel(state)):
        if i == 0 : out+='0'
        elif i == 1 : out+=r'1'
        elif i == 2 : out+=r'2'
        elif i == 3 : out+=r'D'
        if  j+1< state.size:
            out+=','
        else:
            out+= r'>'
    return out

def latex(state):
    out = r"$|"
    for j,i in enumerate(np.ravel(state)):
        if i == 0 : out+='0'
        elif i == 1 : out+=r'\uparrow'
        elif i == 2 : out+=r'\downarrow'
        elif i == 3 : out+=r'\uparrow\! \downarrow'
        if  j+1< state.size:
            out+=','
        else:
            out+= r'\rangle'
    out+=r'$'
    return out

        
import matplotlib.pyplot as plt
import matplotlib
from matplotlib import rc
rc('font',**{'family':'serif'})
      
      
if __name__=="__main__":
    #a = lattice(2,2,1)
    #a.defstates()
    #a.nearest()
    #a.kinetic0()
    #a.interaction0()
    #np.savetxt('221_t.dat', a.kinetic)
    #np.savetxt('221_U.dat', a.inter)
   
    b = lattice(1,2,2)
    b.defstates()
    b.nearest()
    b.kinetic0()
    b.interaction0()
    b.diagonal0()
    np.savetxt('221_t.dat', b.kinetic, fmt='% 01d')
    np.savetxt('221_U.dat', b.inter, fmt='% 01d')

    t = 1. 
    #U = np.concatenate( ( np.linspace(0.1,1.8,3), np.linspace(2.0,10.,16)))
    U = np.linspace(0.1,10.,32)
    eva = []
    eve = []
    for u in U: 
        H = t*b.kinetic + u*b.inter 
        ##print H
        evals,evecs = np.linalg.eigh(H)
        ##print "U = ",u
        ##print evals 
        ##print evecs
        # Sort the eigenvals and eigenvecs 
        index = np.argsort(evals) 
        eva.append(evals[index]) 
        # Ensure the eigenvecs have correct phase
        vecs=[]
        for i in index:
            vec = evecs[:,index[i]] 
            #Find first entry that is non-zero
            i = list(np.abs(vec) > 1e-5).index(True)
            vec = vec / np.sign(vec[i])
            vecs.append(vec) 
        vecs =  np.transpose( np.array(vecs) )
        eve.append(vecs)
        #eve.append(evecs[index])

        ##print 
        ##print evals[index]
        ##print evecs[index]
        ##print "#################"
        ##print index
        ##print 
        ##for i in index:
        ##    print "Eigenvalue  %d = "%i, evals[index[i]]
        ##    print "Eigenvector %d = "%i, evecs[:,index[i]]
        ##    print "H*ev        %d = "%i, np.dot(H, evecs[:,index[i]]) 
        ##    #print np.dot(H, evecs[index[i]]) / evecs[index[i]]
        ##    print  
        
    eva = np.array(eva)
    eve = np.array(eve)

    print "Eigenvalues"
    print eva.shape
    print "Eigenvectors"
    print eve.shape
   
    nstates = len(b.states[0])
    print "Number of States in Sector 0 = ", nstates
    #This number should be a square:
    if np.abs( np.sqrt(nstates) % 1. ) > 1e-4:
        "Error, number of states in Sector 0 is not a square."
    plotrows = int(np.sqrt(nstates))
    plotcols = 2*plotrows
    
    figure = plt.figure(figsize=(12.*plotrows/4,6*plotrows/4))
    print "Making %d x %d figure" % (plotrows, plotcols)
    gs = matplotlib.gridspec.GridSpec( plotrows, plotcols) 
    figure.suptitle('')
    ax = plt.subplot( gs[0:plotrows,0:plotrows] )
    axvs = []
    for i in range(plotrows):
        for j in range(plotrows):
            axvs.append( plt.subplot( gs[i,plotrows+j]))

    c=['blue','green','red','black','purple','limegreen','orange','brown']
    for col in range(eva.shape[1]):
        ax.plot( U, eva[:,col], '-', c=c[col%len(c)],lw=1.5,\
            label='%d'%col)
        if col == 0:
            for i,axv in enumerate(axvs):
                 axv.plot( U, eve[:,i,col],\
                           '-',c=c[col],lw=1.5,\
                label='%d'%col)

  
    # Print out the ground state for various Us
    Uindex=U.size-1
    Eindex =0 
    print
    print "Ground state U=",U[Uindex],"  E=",eva[Uindex,Eindex]
    order =  np.argsort(np.abs(eve[Uindex,:,Eindex]))[::-1]
    for i in order: 
        print "%02d --> % 02.6f   %s" %(i,eve[Uindex,i,Eindex], puretext(b.states[0][i]))
        

    for i,axv in enumerate(axvs):
        axv.text( 0.05,0.95,latex( b.states[0][i]), rotation=0 ,\
                  ha='left',va='top',\
                  bbox=dict(facecolor='white',alpha=1.),\
                  transform=axv.transAxes)
        axv.grid()
        axv.set_ylim(-1,1.)
    ax.grid()
    ax.set_xlabel('$U/t$')
    ax.set_ylabel('$E/t$')
    ax.legend(loc='best',numpoints=1,\
         prop={'size':10}, \
         handlelength=1.1,handletextpad=0.5)
    gs.tight_layout(figure, rect=[0,0.0,1.0,0.96])
    outfile = 'Ut_eigenvalues_2site.png'
    figure.savefig(outfile, dpi=250)
  
        
        
  
    
