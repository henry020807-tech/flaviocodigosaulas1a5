import numpy as np

"Ler  um  arquivo extremo"

f=open("teste1.txt","r")
lines=f.readlines()
result=[]
for x in  lines:
    result.append(x.split('\n'))
f.close()


print(lines)
print(result)



f=open("dataset_spam_r.txt","r")
lines=f.readlines()
result=[]
for x in  lines:
  result.append(x.split('\n'))
f.close()

print(lines)
print(result)

textfile  = open('dataset_spam_r.txt')
data  = []
for line  in  textfile:
  row_data = line.strip("\n").split()
  for i, item in enumerate(row_data):
    try:
         row_data[i] = float(item)
    except  ValueError:
        pass
  data.append(row_data)

print(data)

w=np.array(data)
"Imprima a base de dados"
print(w)
"Imprima o tamanho da base de dados"
print(w.shape)
"Imprima o dado da linha 34 na coluna 57"
print(w[34,57])



ww=w.T
"Os dados em: linha -> variável, coluna -> amostra"
"A matriz está transportada gráças a Numpy"

"Escrever um arquivo externo"
matriz=str(ww)
arquivo = open('python.txt', 'w')
arquivo.writelines(matriz)
arquivo.close()