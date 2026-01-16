# 6375 Project 2 -Evaluation of Tree-Based Classifiers and Their Ensembles

Name: Anil Lingala (akl180001)
Course: CS 6375.001

---

## Project Info
This project builds, tunes, and compares multiple classification models. I implemented and compared:

 - Decision Tree, 
 - Bagging with Decision Tress, 
 Random Forest, and Gradient Boosting 
 
 across various datasets (including MNIST) to study how model type, training size, and feature count affect prediction accuracy and F1 score.
 
 ## Setup
 
 1) Please run the code on Google Colab
 
 2) On the left sidebar, create a new folder called all_data inside /content
    2.1) Create another folder outputs_data for the output results to be stored (the code should automically create it on google colab; but if it doesnt please create manually)
    
 3) Upload all the CSV dataset files to the all_data path
 
  ```
 /content/all_data/
  c300_d100_train.csv
  c300_d100_valid.csv
  c300_d100_test.csv
  c500_d100_train.csv
   ```
   
4)Run the cells in order from top to bottom:
	Cell 1 – Imports and setup
	Cell 2 – Helper functions
	Cells 3 – 8 – Experiments 1 through 6

Wait for each experiment to finish (runtime depends on dataset size).

When finished, all result files will be saved automatically under:
/content/outputs_data

Example outputs:

experiment1_decision_tree.csv
experiment2_bagging.csv
experiment3_random_forest.csv
experiment4_gradient_boosting.csv
experiment5_accuracy_table.csv, experiment5_f1_table.csv
mnist_results.csv
  ...