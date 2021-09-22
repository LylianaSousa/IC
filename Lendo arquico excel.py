import pandas as pd

#o comando abaixo está lendo a minha tabela e identificado que os caracteres são numéricos
x =  pd.read_excel(r"/home/lyliana/Área de Trabalho/ExpPb.xlsx")

#para chamar uma termo especifico da tabela, eu coloco nomeda tabela['nome da coluna'][numero da linha]()aslinhas contam no zero
print (x)

print (x['P (GPa)'][0]+ x['P (GPa)'][1])