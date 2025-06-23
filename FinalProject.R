#  Load Required Libraries
library(MASS)     # For Linear Discriminant Analysis (LDA)
library(rpart)    # For Decision Trees
install.packages("caret")
library(caret)# For cross-validation and model comparison


# Load and preprocess the dataset

# Load dataset (update the working directory first)
data <- read.csv("wdbc.data", header = FALSE)

#Inspect the dataset
head(data) #View first few rows
dim(data) #Check number of rows and columns
str(data) #Get Column  data types
sum(is.na(data)) # To check missing values

# Assign proper column names based on UCI documentation
colnames(data) <- c("ID", "Diagnosis",
                    "radius_mean", "texture_mean", "perimeter_mean", "area_mean", "smoothness_mean",
                    "compactness_mean", "concavity_mean", "concave_points_mean", "symmetry_mean", "fractal_dimension_mean",
                    "radius_se", "texture_se", "perimeter_se", "area_se", "smoothness_se",
                    "compactness_se", "concavity_se", "concave_points_se", "symmetry_se", "fractal_dimension_se",
                    "radius_worst", "texture_worst", "perimeter_worst", "area_worst", "smoothness_worst",
                    "compactness_worst", "concavity_worst", "concave_points_worst", "symmetry_worst", "fractal_dimension_worst")
colnames(data)

# Q.1 Compare Logistic Regression, Linear Discriminant Analysis (LDA), and Decision Tree models on breast cancer diagnosis data

#Convert Diagnosis to a categorical variable (factor)
data$Diagnosis <- as.factor(data$Diagnosis)


# Cross-validation Setup

set.seed(123) # Ensure reproducible results

# Create 5-fold cross-validation settings
ctrl <- trainControl(method = "cv", number = 5)


# Train the models

# Logistic Regression
log_model <- train(Diagnosis ~ ., data = data, method = "glm", family = "binomial", trControl = ctrl)

# Linear Discriminant Analysis (LDA)
lda_model <- train(Diagnosis ~ ., data = data, method = "lda", trControl = ctrl)

# Decision Tree
tree_model <- train(Diagnosis ~ ., data = data, method = "rpart", trControl = ctrl)


# Print accuracy of each model

cat("Logistic Regression Accuracy:", log_model$results$Accuracy, "\n")
cat("LDA Accuracy:", lda_model$results$Accuracy, "\n")
cat("Decision Tree Accuracy:", tree_model$results$Accuracy, "\n")

# Visualize Accuracy Comparison 

# Create a data frame to hold model accuracy values
accuracy_df <- data.frame(
  Model = c("Logistic Regression", "LDA", "Decision Tree"),
  Accuracy = c(
    log_model$results$Accuracy,
    lda_model$results$Accuracy,
    mean(tree_model$results$Accuracy)  # in case of multiple values
  )
)

# Load ggplot2 for plotting
library(ggplot2)

# Create bar plot
ggplot(accuracy_df, aes(x = Model, y = Accuracy, fill = Model)) +
  geom_bar(stat = "identity", width = 0.6) +
  ylim(0, 1) +
  geom_text(aes(label = round(Accuracy, 4)), vjust = -0.5, size = 4.5) +
  labs(title = "Classification Model Accuracy Comparison", y = "Accuracy", x = "Model") +
  theme_minimal()


# Q.2 Determine which of radius_mean, texture_mean, symmetry_mean  best separate benign (B) from malignant (M) tumors

# Re‑train models
set.seed(123)
ctrl <- trainControl(method = "cv", number = 5)
log_model  <- train(Diagnosis ~ ., data = data, method = "glm",   family = "binomial", trControl = ctrl)
tree_model <- train(Diagnosis ~ ., data = data, method = "rpart", trControl = ctrl)

# Step 1: t‑tests for mean differences

features_q2 <- c("radius_mean", "texture_mean", "symmetry_mean")

ttest_list <- lapply(features_q2, function(feat) {
  t <- t.test(data[[feat]] ~ data$Diagnosis)
  data.frame(
    Feature   = feat,
    Mean_B    = round(t$estimate[1], 3),
    Mean_M    = round(t$estimate[2], 3),
    t_stat    = round(t$statistic, 3),
    p_value   = signif(t$p.value, 3)
  )
})
ttest_df <- do.call(rbind, ttest_list)
print(ttest_df)


# Model‑based variable importance

# Logistic regression importance
log_imp  <- varImp(log_model, scale = FALSE)$importance
# Decision tree importance
tree_imp <- varImp(tree_model, scale = FALSE)$importance

# Extract our three features
log_imp_q2  <- log_imp[features_q2, , drop = FALSE]
tree_imp_q2 <- tree_imp[features_q2, , drop = FALSE]

# Combine into one data.frame
importance_df <- data.frame(
  Feature    = rep(features_q2, 2),
  Importance = c(log_imp_q2$Overall, tree_imp_q2$Overall),
  Model      = rep(c("Logistic Regression","Decision Tree"), each = length(features_q2))
)

print(importance_df)


# Visualization

library(ggplot2)

# Bar plot of t‑test p‑values (log scale)
ggplot(ttest_df, aes(x = Feature, y = -log10(p_value))) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(title = "Strength of Mean Difference (–log10 p‑value)",
       y = expression(-log[10](p)), x = "") +
  theme_minimal()

# Bar plot of model importance
ggplot(importance_df, aes(x = Feature, y = Importance, fill = Model)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Feature Importance from Models",
       y = "Importance (caret::varImp)", x = "") +
  theme_minimal()

