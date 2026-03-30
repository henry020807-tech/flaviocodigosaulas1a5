# 1. Instalar e carregar pacotes necessários
if(!require(caret)) install.packages("caret")
if(!require(e1071)) install.packages("e1071")
if(!require(pROC)) install.packages("pROC")

library(caret)
library(e1071)
library(pROC)

# 2.Preparar os dados (Exemplo: iris binário)
data(iris)
# Selecionar apenas duas classes para AUC (binário)
df <- iris[iris$Species != "setosa", ]
df$Species <- factor(df$Species) |

# 3.Configurar a Validação Cruzada (Cross-Validation)
# Usaremos 10-fold CV, com repetição para maior estabilidade 
set.seed(123) # Para reprodutividade 
train_control <- trainControl(
    method = "repeatedcv",
    number = 10,
    repeats = 3,
    classProbs = TRUE,                # Necessário para AU
    summaryFunction = twoClassSummary # Métrica p/ classificação binária (AUC, sens, spec)
    savePredictions = "final"
)

# 4. Treinar o modelo SVM com Kernel Radial (RBF)
# A função train ajusta autoaticamente os hiperparâmetros (C e Sigma)
svm_model <-train(
    Species ~ ., 
    data = df, 
    method = "svmRadial",             # SVM Radial Basis Function 
    trControl = train_control, 
    metric = "ROC"                    # Otimizando pela AUC
    tuneLength = 10                   # Tenta 10 combinações de c e sigma
    preProcess = c("center", "scale") # SVM exige normalização dos dados
)

# 5. Visualizar Resultados
print(svm_model)
pplot(svm_model)

# 6. Avaliar o melhor modelo (AUC)
# As predições de validação cruzada estão no svm_model$pred
best_model <- svm_model$finalModel
cat("AUC Final:", auc(roc_obj), "/n")
plot(roc_obj, main="Curva ROC - SVM", col="blue")