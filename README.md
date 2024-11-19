# ECG R-Peak Detection Using MATLAB

This repository contains a MATLAB script designed to detect R-peaks in ECG (Electrocardiogram) signals using advanced signal processing techniques. The approach involves preprocessing, feature extraction, and logic for accurate R-peak detection in raw ECG data.

## Features

### 1. Preprocessing
- **Bandpass Filtering**: Removes baseline wander and high-frequency noise while preserving essential features.
- **Normalization and Differentiation**: Enhances the QRS complex for better peak detection.

### 2. Feature Extraction
- **Shannon Energy Envelope**: Highlights significant energy changes in the ECG signal.
- **Moving Average Filters**: Smoothens the signal for peak enhancement.

### 3. R-Peak Detection Logic
- Combines squaring, filtering, and a refined search method.
- Identifies peaks in a neighborhood of candidate points for accurate localization.

---

## Workflow

The detection process is divided into four major steps:

### 1. Signal Extraction and Preprocessing
- Load the ECG signal from a `.mat` file.
- Apply a **Chebyshev Type I Bandpass Filter** to eliminate noise.
- Perform **differentiation** and **normalization** to emphasize QRS complexes.

### 2. Shannon Energy Envelope Extraction
- Compute the Shannon Energy Envelope to amplify regions with high energy.
- Smooth the signal using a **moving average filter**.

### 3. Peak Estimation
- Differentiate and square the smoothed signal to highlight peaks.
- Use an additional moving average filter to refine candidate peaks.

### 4. R-Peak Refinement
- Detect peaks from the smoothed signal.
- Refine R-peak positions by searching within a ±25-sample window.
- Overlay detected R-peaks on the original ECG signal.

