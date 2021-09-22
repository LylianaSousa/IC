import numpy as np
import scipy.optimize
import matplotlib.pyplot as plt
import pandas as pd

tabela =  pd.read_excel(r"/home/lyliana/Área de Trabalho/ExpPb.xlsx")

P0 = 1.017*10**(-4)

def pressaoPb(P):
    
    Theta0pb = 86
    Gamma0pb = 2.629
    K0pb = 2091
    Betapb = 0.87
    Deltapb = 1.2
    Bpb = 43.7
    Blpb = 0.44
    Alphapb = 28.9*10**(-6)
    Cpb = 0.55
    T = tabela['T (K)'][0]
    ro_exp = tabela['Resistividade (microOhm*cm)'][0]

    #Definindo as constantes inicias
    Rvolpb0 = (1 - 3*Cpb*Alphapb*(300 - T))*(1 + (P0*Blpb/Bpb))**(-1/Blpb)
    Kpb0 = K0pb*((Rvolpb0)**Betapb)
    Gammapb0 = Gamma0pb*((Rvolpb0)**Deltapb)
    Thetapb0 = Theta0pb*((Rvolpb0)**(-Gammapb0))
    Apb0 = (Kpb0*T)/(4*(Thetapb0**2))
    Bpb0 = (Thetapb0**2)/(18*(T**2))
    Cpb0 = (Thetapb0**4)/(480*(T**4))
    
    resistivityPb0 = Apb0*(1 - Bpb0 + Cpb0)
    ro_exp0 = tabela['Resistividade (microOhm*cm)'][0]
    C = P0*(ro_exp0 - resistivityPb0)
    
    #Definindo a funcao resistividade BG
    
    Rvolpb = (1 - 3*Cpb*Alphapb*(300 - T))*(1 + (P*Blpb/Bpb))**(-1/Blpb)
    Kpb = K0pb*((Rvolpb)**Betapb)
    Gammapb = Gamma0pb*((Rvolpb)**Deltapb)
    Thetapb = Theta0pb*((Rvolpb)**(-Gammapb))
    Apb = (Kpb*T)/(4*(Thetapb**2))
    Bpb = (Thetapb**2)/(18*(T**2))
    Cpb = (Thetapb**4)/(480*(T**4))
    resistivityPb = Apb*(1 - Bpb + Cpb)
    return P - (C)/(resistivityPb - ro_exp)

# Find true roots

rx1 = scipy.optimize.brentq(pressaoPb, 3.0, 0.001)
rx = np.array([rx1])
ry = np.zeros(1)
# print using a list comprehension
print('\nTrue roots:')
print('\n'.join('f({0:0.5f}) = {1:0.2e}'.format(x, pressaoPb(x)) for x in rx))

# Plot function and various roots

x = np.linspace(0, 3, 128)
y = pressaoPb(x)

plt.plot(x, y)
plt.ylim(0, 8)
plt.plot(rx, ry, 'og', ms=5, label='true roots')
plt.legend(numpoints=1, fontsize='small', loc = 'upper right',
           bbox_to_anchor = (0.92, 0.97))
plt.show()