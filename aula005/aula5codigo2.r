# 1. Instalar e carregar o pacote necessário 
if(!require(randomForest)) install.packages("randomForest")
library(randomForest)

# 2. Carregar o Conjunto de Dados (iris)
data(iris)
str(iris) # Visualizar a estrutura de dados3. 

# Preparar os dados: Dividir em conjunto de treinamento (80%) e teste (20%)
set.seed(123) # Definir semente para reprodutibilidade
indices <- sample(1:nrow(iris), size = 0.8 * nrow(iris))
treino <- iris[indices, ]
teste <- iris[-indices, ]

# 4. Treinar o modelo Random Forest
# Species é a variável alvo, '.' indica usar todas as outras variáveis
modelo_rf <- randomForest(Species ~ ,.
                     data = treino, 
                     ntree = 100, # Número de árvores
                     mtry = 2,    # Número de variáveis aleatórias por divisão
                     importance = TRUE) # Calcular importância das variáveis
# Exibir modelo
print(modelo_rf)

# 5. Fazer previsões no conjunto de teste
previsoes <- 