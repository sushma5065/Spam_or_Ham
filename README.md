# Spam Detection in Text Messages

This project uses R and the `quanteda` package to classify text messages as either "spam" or "ham" (non-spam). It employs a Naive Bayes classifier for the task after preprocessing the text data.

## Requirements

To run this project, you will need R installed on your computer, along with the following R packages:
- `quanteda`
- `RColorBrewer`
- `quanteda.textplots`
- `quanteda.textmodels`

You can install these packages using the R command `install.packages()` if you do not already have them.

## Dataset

The dataset used in this project is a collection of SMS messages labeled as spam or ham. It's expected to be in a CSV format with at least two columns: "Category" and "Message".

## How to Run

1. Load the necessary R packages using `library(packageName)`.
2. Load your dataset. Adjust the path to where your CSV file is stored.
3. The script will:
   - Prepare the data by shuffling and creating a corpus from the text.
   - Preprocess the text data by removing punctuation, numbers, symbols, and stopwords, then apply tokenization.
   - Create a document-feature matrix (DFM) and apply TF-IDF weighting.
   - Split the dataset into training and testing sets.
   - Train a Naive Bayes classifier and make predictions on the test set.
   - Calculate and print the accuracy of the model on both training and testing sets.
   - Predict the category of example texts.

## Example Output

When you run the script with example texts, you should expect an output like the following, which predicts the category ("ham" or "spam") for each input text:

