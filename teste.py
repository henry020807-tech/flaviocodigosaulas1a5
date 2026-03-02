import numpy as np 

class Perceptron:
    def _init_(self, taxa_aprendizado=0.01, n_iter=100):
        self.taxa_aprendizado = taxa_aprendizado
        self.n_iter = n_iter
        self.pesos = None
        self.bias = None
        self.registro_erros = []
        
    def fit(self, X, y):
        n_amostras, n_features = X.shape
        
        # Inicialização dos pesos e bias com zero
        self.pesos = np.zeros(n_features)
        self.bias = 0
        self.registro_erros = []
        
        for _ in range(self.n_iter):
            erros = 0
            for xi, target in zip(X, y):
                soma_ponderada = np.dot(xi, self.pesos) + self.bias
                pred = self.ativacao(soma_ponderada)
                
                erro = target - pred
                
                if erro != 0:
                    self.pesos += self.taxa_aprendizado * erro * xi
                    self.bias += self.taxa_aprendizado * erro
                    erros += 1
            
            self.registro_erros.append(erros)
            
        return self
    
    def ativacao(self, z):
        return np.where(z >= 0, 1, 0)
    
    def predict(self, X):
        soma_ponderada = np.dot(X, self.pesos) + self.bias
        return self.ativacao(soma_ponderada)


# ======================================
# TESTE 1 - Porta AND
# ======================================

X = np.array([[0, 0], [0, 1], [1, 0], [1, 1]]) 
y = np.array([0, 0, 0, 1])

ppn = Perceptron(taxa_aprendizado=0.1, n_iter=10)
ppn.fit(X, y)

print("Treinamento da porta AND")
print("Pesos após treinamento:", ppn.pesos)
print("Bias após treinamento:", ppn.bias)
print("Previsões:", ppn.predict(X))


# ======================================
# TESTE 2 - Porta OR
# ======================================

X = np.array([[0, 0], [0, 1], [1, 0], [1, 1]]) 
y = np.array([0, 1, 1, 1])

ppn = Perceptron(taxa_aprendizado=0.1, n_iter=10)
ppn.fit(X, y)

print("\nTreinamento da porta OR")
print("Pesos após treinamento:", ppn.pesos)
print("Bias após treinamento:", ppn.bias)
print("Previsões:", ppn.predict(X))


# ======================================
# TESTE 3 - Porta OR com 3 entradas
# ======================================

X = np.array([
    [0, 0, 0], 
    [0, 0, 1], 
    [0, 1, 0], 
    [0, 1, 1], 
    [1, 0, 0], 
    [1, 0, 1], 
    [1, 1, 0], 
    [1, 1, 1]
]) 

y = np.array([0, 1, 1, 1, 1, 1, 1, 1])

ppn = Perceptron(taxa_aprendizado=0.1, n_iter=10)
ppn.fit(X, y)

print("\nTreinamento da porta OR com 3 entradas")
print("Pesos após treinamento:", ppn.pesos)
print("Bias após treinamento:", ppn.bias)
print("Previsões:", ppn.predict(X))


# ======================================
# TESTE 4 - Porta XOR (não converge)
# ======================================

X = np.array([[0, 0], [1, 0], [0, 1], [1, 1]]) 
y = np.array([0, 1, 1, 0])

ppn = Perceptron(taxa_aprendizado=0.1, n_iter=10)
ppn.fit(X, y)

print("\nTreinamento da porta XOR")
print("Pesos após treinamento:", ppn.pesos)
print("Bias após treinamento:", ppn.bias)
print("Previsões:", ppn.predict(X))
