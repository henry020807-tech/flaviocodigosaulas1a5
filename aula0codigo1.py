import  numpy as  np
x=2
print(x)

for i in  range(4):
  x=x+1
print(x)
x=2
print("variáveis")
print(x)
"vetores"
a=[1,5,4,5,6,7]
print("vetores")
print(a)
print(sorted(a))
print(sorted(a, reverse=True))
"Matrizes - instalar: conda install numpy"
import  numpy
M=numpy.array([[1,2,3],[4,5,6],[7,8,9]])
print("Matrizes")
print(M)
print("Acessando Matrizes  (começa do  indices 0)")
print(M [0][2])
"for"
for i in  range(4):
  x=x+1
  print(x)
  
print("Loop for")
print(x)
"while"
while x>1:
  M = M*2
  x=x-1
  print(x)
  print(M)
print("Loop while")
print(x)
print(M)

"condição"
if  x<1:
  print("condição aceita")
else:
  print("condição não aceita")