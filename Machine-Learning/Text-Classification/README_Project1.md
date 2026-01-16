# CS 6375 Project 1 - Spam Classification

Name: Anil Lingala (akl180001)  

---

## Project Info
This project is about detecting spam emails. I implemented and compared:

- Multinomial Naive Bayes (Bag of Words)
- Bernoulli Naive Bayes (Presence/Absence)
- Logistic Regression (MCAP with L2 regularization)

Datasets used: enron1, enron2, enron4 (train/test splits, each has spam/ham folders).

---

## Setup
I ran everything on Google Colab.

1. Put the dataset into Google Drive at this path:
   /content/drive/MyDrive/Colab Notebooks/Project 1/datasets

2. Mount the drive in Colab:
   ```python
   from google.colab import drive
   drive.mount('/content/drive')
   ```

3. Install tools (if needed):
   ```python
   import nltk
   nltk.download('punkt')
   nltk.download('stopwords')
   nltk.download('punkt_tab')
   ```
   (only first run needs this)

---

## How to Run
The code is broken into steps.

### Step 1: Data prep
- Preprocess emails (lowercase, remove punctuation, tokenize, remove stopwords)
- Build vocab
- Generate Bag-of-Words and Bernoulli feature matrices
- Save as CSV files (12 in total)

Run:
```python
dataset_splits = find_dataset_splits(BASE_DIR)
for dataset_name, train_path, test_path in dataset_splits:
    generate_csv(dataset_name, train_path, test_path, BASE_DIR)
```

### Step 2: Multinomial NB
Train/test with BoW CSVs.
```python
results = {}
for ds in ["enron1", "enron2", "enron4"]:
    results[ds] = evaluate_dataset_mnb_bow(ds, alpha=1.0)
print_multinomial_results(results)
```

### Step 3: Bernoulli NB
Train/test with Bernoulli CSVs.
```python
bernoulli_results = {}
for ds in ["enron1", "enron2", "enron4"]:
    bernoulli_results[ds] = evaluate_dataset_bnb_bernoulli(ds, alpha=1.0)
print_bernoulli_results(bernoulli_results)
```

### Step 4: Logistic Regression (MCAP)
Gradient ascent with L2 regularization.
I tuned λ over (0.1, 0.01, 0.001).

Run:
```python
print_logreg_grid(lambda_list=(0.1, 0.01, 0.001), lr=0.01, iters=500)
```

### Step 5: Results
Tables print out for accuracy, precision, recall, f1.
Copy these into the report.

---

## Notes
- Make sure BASE_DIR matches the dataset path.
- Logistic Regression can be slow if you crank iterations too high.
- If results are too weird (like 99% acc on enron1), check preprocessing or stopwords.

---

## Output
- 12 CSV files
- Tables for Multinomial NB, Bernoulli NB, Logistic Regression
- Report answering the project questions

