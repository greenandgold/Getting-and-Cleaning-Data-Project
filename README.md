# Course Project for Coursera's Getting and Cleaning Data Course

## Summary

The project uses the the [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) data set. 

## Contents

This repository contains the following files:

* README.md - a file summarizing the project

* run_analysis.R - the R script that takes the original Human Activity Recognition data set and produces the file averages.txt

* CodeBook.md - a code book describing all variables and transformations to clean the data

* averages.txt - a file with averages for each variable for each activity and each subject

## Work Performed

Test data for mean and standard deviation measurements is combined into one data frame using subject_test.txt, y_test.txt, and X_test.txt.

Training data for mean and standard deviation measurements is combined into one data frame using subject_train.txt, y_train.txt, and X_train.txt.

Test and training data sets are merged, labeled, and reshaped.

A data frame with averages for each variable for each activity and each subject is written to the\file averages.txt.

