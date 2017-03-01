---
title: "ReadMe"
author: "Lorenzo A Sanchez"
date: "March 1, 2017"
output: html_document
---

# Getting and Cleaning Data - Course Project

These are the course project deliverables for the 'Getting and Cleaning Data' Coursera course.

The R script `run_analysis.R` does the following:

1. Downloads the data zip file if it does not already exist in the working directory and unzips its contents
2. Loads activity labels and features
3. Extracts mean and std. dev. feature data
4. Loads "test"" and ""train" data and adds `activity` and `subject` columns
5. Merges the "train" and "test"" data and adds the `subject` and `activity` labels
6. Converts `subject` and `activity` columns into factor variables
7. Writes the `tidy.txt` file that gives the mean of all variables per `subject` and per `activity`