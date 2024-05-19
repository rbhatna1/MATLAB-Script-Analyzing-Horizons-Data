# MATLAB-Script-Analyzing-Horizons-Data

## Overview
This MATLAB script processes and analyzes data related to astronomical horizons. It performs tasks such as loading data from a file, locating perihelia, selecting data based on specific criteria, and plotting the results. The script consists of several functions that work together to achieve these tasks.

## Functions

### `tspAnalyze`
- **Description**: Main function that orchestrates the execution of the script. It loads data, displays a menu, and processes user choices.
- **Side Effects**: Loads data from `tspData.mat`, displays text from `tspAbout.txt`, prints menu, and handles user inputs.

### `loaddata`
- **Description**: Loads data from a specified file.
- **Side Effects**: Displays filename and data size on the command window.
- **Input Arguments**: `filename` - Name of the file to load.
- **Output Arguments**: `data` - Loaded data as a cell array.

### `str2cell`
- **Description**: Converts a line of string data into a cell array.
- **Side Effects**: None.
- **Input Arguments**: `linestr` - Line of string data.
- **Output Arguments**: `cellrow` - Cell array with parsed data.

### `locate`
- **Description**: Locates perihelia based on a threshold value.
- **Side Effects**: None.
- **Input Arguments**: `data` - Data array, `thresh` - Threshold value.
- **Output Arguments**: `data` - Filtered data array.

### `select`
- **Description**: Selects data based on specific criteria.
- **Side Effects**: None.
- **Input Arguments**: `data` - Data array, `~` - Placeholder arguments.
- **Output Arguments**: `data` - Selected data array.

### `makeplot`
- **Description**: Plots the processed data and saves the plot as an image.
- **Side Effects**: Saves the plot as a `.tif` file.
- **Input Arguments**: `data` - Data array, `filename` - Name of the output file.
- **Output Arguments**: None.

### `arcsec`
- **Description**: Converts data into arcseconds for plotting.
- **Side Effects**: None.
- **Input Arguments**: `data` - Data array.
- **Output Arguments**: `numdate` - Numeric dates, `strdate` - String dates, `precess` - Precession data.

### `annotate`
- **Description**: Annotates the plot with labels, ticks, and legend.
- **Side Effects**: None.
- **Input Arguments**: `numdate` - Numeric dates, `strdate` - String dates, `slope` - Slope of the best fit line.
- **Output Arguments**: None.

## Usage
1. **Run the Script**: Execute the main section of the script in MATLAB.
2. **View Data**: The script loads data from a file and processes it.
3. **Plot Results**: The script generates a plot of the processed data and saves it as an image file.
