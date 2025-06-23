# INFO 6105 Final Project: Breast Cancer Diagnosis Analysis using R

**Author**: Geetika Barla  
**Course**: INFO 6105 – Data Science Programming Methods  
**University**: Northeastern University  

---

## 🧠 Project Overview

This project uses the **Breast Cancer Wisconsin (Diagnostic)** dataset from the UCI Machine Learning Repository to build classification models and analyze which features are most effective in distinguishing between **malignant (M)** and **benign (B)** tumors.

The analysis was done using R and focuses on:

- Model comparison: Logistic Regression vs LDA vs Decision Tree
- Feature importance: Identifying the most predictive features (radius, texture, symmetry)
- Statistical significance: Using t-tests to find differentiating characteristics

---

## 📂 Repository Contents

| File Name               | Description                                                       |
|------------------------|-------------------------------------------------------------------|
| `FinalProject.R`        | Main R script for data loading, preprocessing, model training, and visualization |
| `FinalProjectReport.pdf` | Full written report explaining objectives, methodology, results, and conclusions |
| `GeetikaPPT.pdf`        | Presentation slides used to showcase the project |
| `DSMFinalProject.mp4`   | [Video presentation (Click to view)](https://northeastern-my.sharepoint.com/personal/barla_g_northeastern_edu/_layouts/15/stream.aspx?id=/personal/barla_g_northeastern_edu/Documents/DSMFinalProject.mp4&referrer=StreamWebApp.Web) |

---

## 📊 Dataset Summary

- **Source**: [UCI ML Repository](https://archive.ics.uci.edu/dataset/17/breast+cancer+wisconsin+diagnostic)
- **Records**: 569 samples of cell nuclei
- **Target Variable**: Diagnosis (`M` = Malignant, `B` = Benign)
- **Features**: 30 numeric attributes describing cell nuclei characteristics (mean, standard error, and worst)

---

## 🔍 Questions Addressed

1. **Which classification algorithm performs best?**
   - Logistic Regression
   - Linear Discriminant Analysis (LDA)
   - Decision Tree

2. **Which features best separate malignant from benign tumors?**
   - `radius_mean`
   - `texture_mean`
   - `symmetry_mean`

---

## 🧪 Methodology

- **Cross-validation**: 5-fold CV using `caret` package
- **Evaluation Metric**: Accuracy
- **Model Comparison**:
  - **LDA** performed best (95.78% accuracy)
  - Followed by **Logistic Regression** (94.38%)
  - **Decision Tree** trailed behind (89.52%)

- **Feature Importance**:
  - **Statistical Testing**: t-tests on mean values across diagnoses
  - **Model-Based**: `varImp()` used to measure influence in models
  - **Findings**:
    - `radius_mean` had highest statistical separation
    - `texture_mean` was most impactful for Decision Trees
    - Logistic Regression showed balanced importance across all three

---

## 📦 R Packages Used

- `caret`: Cross-validation and model training
- `rpart`: Decision tree classifier
- `MASS`: LDA implementation
- `ggplot2`: Data visualization

---

## 📈 Visual Highlights

- Bar plots comparing model accuracies
- –log₁₀(p-value) plot showing statistical feature significance
- Feature importance plot from model-based analysis

---

## 🔗 Resources

- [Dataset on UCI](https://archive.ics.uci.edu/dataset/17/breast+cancer+wisconsin+diagnostic)
- [Video Walkthrough](https://northeastern-my.sharepoint.com/personal/barla_g_northeastern_edu/_layouts/15/stream.aspx?id=/personal/barla_g_northeastern_edu/Documents/DSMFinalProject.mp4&referrer=StreamWebApp.Web)

---

## ✅ Conclusion

The project demonstrates how both statistical and machine learning techniques can be used to derive insights from medical datasets. It highlights the importance of model selection and feature interpretation in building accurate and interpretable diagnostic systems.

---
