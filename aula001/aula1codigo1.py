from matplotlib.lines import lineStyles
from re import A

import  csv

# 'with  open'  garante que o arquivo será  fechado automaticamente
with  open('Base-1.csv',  'r',  newline='', encoding='utf-8') as  arquivo_csv:
  leitor_csv  = csv.reader(arquivo_csv)
  matriz_lista_de_listas  = list(leitor_csv)  # converte  todas as  linhas  em  uma linhas  em  uma lista

# Se  quiser  remover o cabeçalho (primeira linha)
# matriz_lista_-de-listas = list(leitor_csv)[1:]  #ignora a primeira  linha

print(matriz_lista_de_listas[1:]) #Imprima  a linha 1


import  numpy as  np
import  csv
import  matplotlib.pyplot  as  plt


# Substitua 'seu_arquivo.csv' pelo  nome  do  seu arquivo
# delimiter=',' indica  que os  valores são separados por vírgula
# sliprows=1  ignora  o   cabeçalho,  se  houver
matriz_numpy  = np.loadtxt('Base-1-Numérica.csv', delimiter=',',  skiprows=1)

print(matriz_numpy)
print("Tamanho  da  Base")
print(matriz_numpy.shape)
print("Linha  1  - colunas de  3 a 10")
print(matriz_numpy[1:,15:18])
print(matriz_numpy[1,16])


import  statistics
media = statistics.mean(matriz_numpy[:,16])
print("Esta  é a média do  tempo de  internação  - Base tratada")
print(media)
desvio=statistics.stdev(matriz_numpy[:,16])
print("Esta é o desvio  padrão  do  tempo de  internação  - Base tratada")
print(desvio)
variancia=statistics.variance(matriz_numpy[:,16])
print("Esta é a variância do  tempo de  internação  - Base  tratada")
print(variancia)
moda=statistics.mode(matriz_numpy[:,16])
print("Está é a moda  do  tempo de  internação -  Base tratada")
print(moda)
mediana=statistics.median(matriz_numpy[:,16])
print("Esta é a mediana do  tempo de  internação  - Base  tratada")
print(mediana)
plt.hist(matriz_numpy[:,16], bins=30)
plt.xlabel('Tempo de  Interação')
plt.ylabel('Frequência')
plt.title('Histograma do  Tempo de  Internação')
plt.show

import matplotlib.pyplot as plt

plt.hist(matriz_numpy[:,16],  bins=5 ,  edgecolor='black',  alpha=0.7) # bins= número  de  barras
plt.axvline(media,  color='red',  linestyle='--',  linewidth=2,  label=f'Média ({media:.2f})')
plt.axvline(media + desvio, color='green',  linestyle=':',  linewidth=2,  label=f'+1  DP')
plt.axvline(media - desvio, color='green',  linestyle=':',  linewidth=2,  label=f'-1  DP')
plt.title('Histograma  com Média e Desvio  Padrão')
plt.xlabel('Valores')
plt.ylabel('Frequência')
plt.legend()
plt.show()