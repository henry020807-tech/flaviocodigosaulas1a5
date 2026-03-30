from sklearn.datasets import load_breast_cancer 
from sklearn.model_selection import train_test_split 
from sklearn.preprocessing import StandardScaler
from sklearn.neural_network import MLPClassifier
from sklearn.metrics import accuracy_score, classification_report

# 1. Carregar os dados 
data = load_breast_cancer()
x = data.data
y = data.target 

print(x)
print(y)

# 2. Dividir em conjunto de treinamento (80%) e teste (20%)
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.2, random_state=42)
                                                   
# 3. Normalização de dados (Feature Scaling)
# Redes neurais convergem mais rápido com dados normalizados (média 0,variância 1)
scaler = StandardScaler()
x_train_scaled = scaler.fit_transform(x_train)
x_test_scaled = scaler.transform(x_test)

# 4. Criar o modelo MLP
# hidden_layer_sizes=(64, 32): 2 camadas ocultas (64 neurônios na 1ª camada, 32 na 2ª)
# max_iter=1000: número máximo de épocas de treinamentos
mlp = MLPClassifier(hidden_layer_sizes=(64, 32), max_iter=1000, random_state=42)

# 5. Treinar o modelo
mlp.fit(x_train_scaled, y_train)

# 6. Pervisões e Avaliação
y_pred = mlp.predict(x_test_scaled)
accuracy = accuracy_score(y_test, y_pred)

print(f"Acurácia do Modelo: {accuracy:.2f}")
print("\nRelatório de Classificação:\n")
print(classification_report(y_test, y_pred))