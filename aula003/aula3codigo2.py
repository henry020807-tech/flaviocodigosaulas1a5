import matplotlib.pyplot as plt
import numpy as np
from sklearn.datasets import load_breast_cancer
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.neural_network import MLPClassifier
from sklearn.metrics import roc_curve, auc, classification_report, RocCurveDisplay
from sklearn.metrics import confusion_matrix, ConfusionMatrixDisplay

# 1. Carregar o dataset
data = load_breast_cancer()
X = data.data
y = data.target
#conheça sua base de dados
print(data.DESCR)

# 2. Dividir em treino e teste 
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42, stratify=y)

# 3. Normalização (Essencial para reder neurais)
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

# 4. Criar o modelo MLP
# hidden_layer_sizes=(100,50) cria 2 camaadas ocultas 
mlp = MLPClassifier(hidden_layer_sizes=(100, 50), max_iter=500,
                    activation='relu', solver='adam',
                    random_state=42, verbose=False)

# Treinamento
mlp.fit(X_train_scaled, y_train)

# 5. Visualização do Erro (Loss Curve)
plt.figure(figsize=(10, 5))
plt.plot(mlp.loss_curve_)
plt.title("Curva de Erro durante Treinamento (Loss Curve)")
plt.xlabel("Épocas")
plt.ylabel("Erro (Loss)")
plt.grid("True")
plt.show()

# 6. Avaliação e Gráfico AUC-ROC
y_pred_proba = mlp.predict_proba(X_test_scaled)[:, 1]
fpr, tpr, thresholds = roc_curve(y_test, y_pred_proba)
roc_auc = auc(fpr, tpr)

plt.figure(figsize=(10, 5))
plt.plot(fpr, tpr, color='darkorange', lw=2, label=f'ROC curve (area = {roc_auc:.2f})')
plt.plot([0, 1], [0,1], color='navy', lw=2, linestyle='--')
plt.xlim([0.0, 1.0])
plt.ylim([0.0, 1.05])
plt.xlabel('Taxa de Falsos Positivos')
plt.ylabel('Taxa de Verdadeiros Positivos')
plt.title('Curva ROC - MLP Breast Cancer')
plt.legend(loc="lower right")
plt.grid(True)
plt.show()

# 7. Relatório de Classificação 
y_pred = mlp.predict(X_test_scaled)
print("Relatório de Classificação:\n")
print(classification_report(y_test, y_pred, target_names=data.target_names))