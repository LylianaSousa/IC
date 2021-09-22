import pandas as pd
from scipy.optimize import fsolve
#Primeira etapa: Ler arquivo excel 

#o comando abaixo está lendo a minha tabela e identificado que os caracteres são numéricos
x =  pd.read_excel(r"/home/lyliana/Área de Trabalho/ExpPb.xlsx")

#vou citar todas as constantes para calcular a resistividade BG
Theta0pb = 86
Gamma0pb = 2.629
K0pb = 2091
Betapb = 0.87
Deltapb = 1.2
Bpb = 43.7
Blpb = 0.44
Alphapb = 28.9*10**(-6)
Cpb = 0.55
P0 = 1.017*10**(-4)

#para chamar uma termo especifico da tabela, eu coloco nomeda tabela['nome da coluna'][numero da linha]()aslinhas contam no zero
#vou criar um while para calcular a equacao para cada termo da planilha, que nesse caso e 15
i = 0
while i <= 15:
    #Segunda etapa: Identificar resistividade experimental e T
    T = x['T (K)'][i]
    ro_exp = x['Resistividade (microOhm*cm)'][i]
    
    #Definindo as constantes inicias
    Rvolpb0 = (1 - 3*Cpb*Alphapb*(300 - T))*(1 + (P0*Blpb/Bpb))**(-1/Blpb)
    Kpb0 = K0pb*((Rvolpb0)**Betapb)
    Gammapb0 = Gamma0pb*((Rvolpb0)**Deltapb)
    Thetapb0 = Theta0pb*((Rvolpb0)**(-Gammapb0))
    Apb0 = (Kpb0*T)/(4*(Thetapb0**2))
    Bpb0 = (Thetapb0**2)/(18*(T**2))
    Cpb0 = (Thetapb0**4)/(480*(T**4))
    
    resistivityPb0 = Apb0*(1 - Bpb0 + Cpb0)
    ro_exp0 = x['Resistividade (microOhm*cm)'][0]
    C = P0*(ro_exp0 - resistivityPb0)

    #Terceira etapa: Substituir resistividade experimental e temperatura na equacao
    #Definindo a funcao resistividade BG
    
    Rvolpb = (1 - 3*Cpb*Alphapb*(300 - T))*(1 + (P*Blpb/Bpb))**(-1/Blpb)
    Kpb = K0pb*((Rvolpb)**Betapb)
    Gammapb = Gamma0pb*((Rvolpb)**Deltapb)
    Thetapb = Theta0pb*((Rvolpb)**(-Gammapb))
    Apb = (Kpb*T)/(4*(Thetapb**2))
    Bpb = (Thetapb**2)/(18*(T**2))
    Cpb = (Thetapb**4)/(480*(T**4))
    resistivityPb = Apb*(1 - Bpb + Cpb)
    
    #Definindo a funcao que vai definir a pressao
    
    P = (C)/(resistivityPb - ro_exp)
    
    #Quarta etapa: Encontrar o valor de P para as variaveis anterios 

    

#Quinta etapa: Colocar os dados no arquivo