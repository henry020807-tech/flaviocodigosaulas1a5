
rm(list=ls())
# 1. Instalar e carregar pacotes necessários
if(!require(neuralnet)) install.packages("neuralnet")
if(!require(ROCR)) install.packages("ROCR")


# 2. Carregar e Preparar a base Iris
data(iris)

# A base iris precisa ser numérica. Vamos transformar 'Species' em 3 colunas binárias (dummy)
# 1 = Setosa, 2 = Versicolor, 3 = Virginica
iris_dummy <- cbind(iris[,1:4], class2ind(as.factor(iris$Species)))
names(iris_dummy) <- c("Sepal.Length", "Sepal.Width", "Petal.Length",
                       "Petal.Width", "Setosa", "Versicolor", "Virginica")

# Normalização (min-max) - Importante para redes neurais
normalize <- function(x) {
    return ((x - min(x)) / (max(x) - min(x)))
}
iris_norm <- as.data.frame(lapply(iris_dummy[,1:4], normalize))
iris_norm <- cbind

# Divisão em Treino (70%) e Teste (30%)
set.seed(123)
index <- sample(1:nrow(iris_norm), round(0.7 * nrow(iris_norm)))
train_data <- iris_norm[index, ]
test_data <- iris_norm[-index, ]

# 3.Treinar a MLP
# Usamos duas camadas ocultas com 4 e 3 neurônios 
# err.fct = 'ce' (cross-entropy) é recomendado para classificação 
nn <- neuralnet(Setosa + Versicolor + Virginica~
                  Sepal.Length + Sepal.Width + Petal.Length + Petal.Width,
                data = train_data, hidden = c(4, 3),
                linear.output = FALSE, act.fct = "logistic",
                err.fct = "ce", lifesign = "minimal")

# 4. Visualizar a rede neural 
plot(nn, rep = "best")

# 5. Gráfico de Erro (Convergência)
# O neuralnet armazena o valor do erro na última etapa
plot(nn$result.matrix[,1], type = "l", main = "Convergência do Erro (Training)",
     ylab = "Erro (Cross-Entropy)", xlab = "Interação")

# 6. Avaliação AUC
# Previsão
Predict_nn <- compute(nn, test_data[, 1:4])
probs <- predict_nn$net.result

# Encontrar a classe com maior probabilidade 
predictions <- apply(probs, 1, which.max)
labels <- apply(test_data[, 5:7], 1, which.max)

# Matriz de Confusão
table(predictions, labels)

# Calcular AUC (usando pacote ROCR - tratando como multi-classe)
# Para este exemplo, calcularemos AUC para a classe Virginica como exeplo binário 
pred_obj <- prediction(probs[, 3], test_data$Virginica)
perf_roc <- performance(pred_obj, "tpr", "fpr")
plot(a=0, b=1, lwd=2, lty=2, col="gray")

auc_val <- performance(pred_obj, measure = "auc")
print(paste("AUC da classe Virginica:", round(as.numeric(auc_val@y.values), 4)))