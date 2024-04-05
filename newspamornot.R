# Required package installation and loading
if (!require("quanteda")) install.packages("quanteda")
if (!require("RColorBrewer")) install.packages("RColorBrewer")
if (!require("quanteda.textplots")) install.packages("quanteda.textplots")
if (!requireNamespace("quanteda.textmodels", quietly = TRUE)) install.packages("quanteda.textmodels")
library(quanteda)
library(RColorBrewer)
library(quanteda.textplots)
library(quanteda.textmodels)

# Data loading
raw.data <- read.csv("C://Users//karth//Downloads//SPAM text message 20170820 - Data.csv", header = TRUE, sep = ",", quote = "\"\"", stringsAsFactors = FALSE)

# Data preparation
set.seed(1912)  
raw.data <- raw.data[sample(nrow(raw.data)),]
sms.corpus <- corpus(raw.data, text_field = "Message")
tokens_obj <- tokens(sms.corpus, remove_punct = TRUE, remove_numbers = TRUE, remove_symbols = TRUE, remove_url = TRUE) %>% tokens_remove(stopwords(source = "smart"), padding = FALSE)

# DFM creation
dfm_obj <- dfm(tokens_obj)
sms.dfm <- dfm(tokens_obj)
sms.dfm <- dfm_trim(sms.dfm, min_count = 5, min_docfreq = 3)
sms.dfm <- dfm_tfidf(sms.dfm)

# Model training
sms.raw.train <- raw.data[1:4738,]
sms.raw.test <- raw.data[4739:nrow(raw.data),]
sms.classifier <- textmodel_nb(sms.dfm[1:4738,], y = sms.raw.train$Category)

# Prediction and accuracy calculation
sms.predictions <- predict(sms.classifier, newdata = sms.dfm[4739:nrow(raw.data),])
predicted_categories <- factor(sms.predictions, levels = c("ham", "spam"))
actual_categories <- factor(sms.raw.test$Category, levels = c("ham", "spam"))
correct_predictions <- sum(predicted_categories == actual_categories)
accuracy <- correct_predictions / length(actual_categories)
print(paste("Accuracy:", accuracy))

# Assuming all previous steps are as provided

# Training set predictions
train_predictions <- predict(sms.classifier, newdata = sms.dfm[1:4738,])
train_predicted_categories <- factor(train_predictions, levels = c("ham", "spam"))
train_actual_categories <- factor(sms.raw.train$Category, levels = c("ham", "spam"))
train_correct_predictions <- sum(train_predicted_categories == train_actual_categories)
train_accuracy <- train_correct_predictions / length(train_actual_categories)
print(paste("Training Accuracy:", train_accuracy))

# Testing set predictions
test_predictions <- predict(sms.classifier, newdata = sms.dfm[4739:nrow(raw.data),])
test_predicted_categories <- factor(test_predictions, levels = c("ham", "spam"))
test_actual_categories <- factor(sms.raw.test$Category, levels = c("ham", "spam"))
test_correct_predictions <- sum(test_predicted_categories == test_actual_categories)
test_accuracy <- test_correct_predictions / length(test_actual_categories)
print(paste("Testing Accuracy:", test_accuracy))

# Example text prediction (as before)
example_texts <- c("Awesome, I remember the last time we got somebody high for the first time with diesel :V",
                   "Fancy a shag? I do.Interested? sextextuk.com txt XXUK SUZY to 69876. Txts cost 1.50 per msg. TnCs on website. X")
example_tokens <- tokens(example_texts, remove_punct = TRUE, remove_numbers = TRUE, remove_symbols = TRUE, remove_url = TRUE) %>% tokens_remove(stopwords(source = "smart"), padding = FALSE)
example_dfm <- dfm(example_tokens)
example_dfm_conform <- dfm_match(example_dfm, features = featnames(sms.dfm))
example_prediction <- predict(sms.classifier, newdata = example_dfm_conform)
print(example_prediction)