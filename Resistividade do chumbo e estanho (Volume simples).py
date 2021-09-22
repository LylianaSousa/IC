from pylab import plot, show, xlabel, ylabel, title
from numpy import linspace

#Identificando as constantes
T = 300
Theta0pb = 86
Theta0sn = 210
Gamma0pb = 2.629
Gamma0sn = 2.1
K0pb = 2091
K0sn = 7440
Betapb = 0.87
Betasn = 0.78
Deltapb = 1.2
Deltasn = 1.8
Bpb = 43.7
Bsn = 55.81
Blpb = 0.44
Blsn = 0.27152
Alphapb = 28.9*10**(-6)
Alphasn = 21.2*10**(-6)
Cpb = 0.55
Csn = 0.70
P0 = 1*10**(-4)
P = linspace(P0, 3, 10000000)

#Funcao que descreve a resistividade do Chumbo
Kpb = K0pb*((P0/P)**Betapb)
Gammapb = Gamma0pb*((P0/P)**Deltapb)
Thetapb = Theta0pb*((P0/P)**(-Gammapb))
Apb = (Kpb*T)/(4*(Thetapb**2))
Bpb = (Thetapb**2)/(18*(T**2))
Cpb = (Thetapb**4)/(480*(T**4))
resistivityPb = Apb*(1 - Bpb + Cpb)

#Resistividade inicial (usar o valor da resistencia do chumbo em microOhms*cm)
resistivityPb0 = 22

#Graficos do chumbo
plot(P, (resistivityPb)/(22))
xlabel('P (GPa)')
ylabel('Rpb(P)/Rpb(0)')
title('Razao da Resistencia do Chumbo com a resistencia inicial do chumbo')
show()

plot(P, resistivityPb)
xlabel('P (GPa)')
ylabel('ResistivityPb(P) (microOhm*cm)')
title('Resistividade do Chumbo em funcao da pressao')
show()

#Funcao que descreve a resistividade do Estanho
Ksn = K0sn*((P0/P)**Betasn)
Gammasn = Gamma0sn*((P0/P)**Deltasn)
Thetasn = Theta0sn*((P0/P)**(-Gammasn))
Asn = (Ksn*T)/(4*(Thetasn**2))
Bsn = (Thetasn**2)/(18*(T**2))
Csn = (Thetasn**4)/(480*(T**4))
resistivitySn = Asn*(1 - Bsn + Csn)

#Resistividade inicial (usar o valor da resistencia do estanho em microOhms*cm)
resistivitySn0 = 10.9

#Graficos do chumbo
plot(P, (resistivitySn)/(10.9))
xlabel('P(GPa)')
ylabel('Rsn(P)/Rsn(0)')
title('Razao da Resistencia do Estanho com a resistencia inicial do Estanho')
show()

plot(P, resistivitySn)
xlabel('P(GPa)')
ylabel('ResistivitySn(P) (microOhm*cm)')
title('Resistividade do Estanho em funcao da pressao')
show()


