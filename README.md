# Data Visualization using ggplot2 – Program 1

## Aim

Create scatter plots and smooth trend lines using the `mpg` dataset in `ggplot2` to visualize the relationship between engine displacement (`displ`), highway mileage (`hwy`), and drive type (`drv`).[web:10][web:11]

## Dataset

We use the built-in `mpg` dataset from the `ggplot2` package.

- `displ`: engine displacement (litres).[web:10]  
- `hwy`: highway miles per gallon.[web:10]  
- `drv`: drive type (`f` = front-wheel, `r` = rear-wheel, `4` = 4 wheel drive).[web:10]

## Task

Create an R script named **`solution.R`** in the root of this repository.  
In that file, you must:

1. Load `ggplot2` and the `mpg` dataset.
2. Create the four plots and assign them to variables with *exact* names plot1, plot2, plot3 and plot4

3. Do **not** print the plots in the script; just create the objects `plot1`, `plot2`, `plot3`, and `plot4`.

> The autograder will import `solution.R` and check that these four objects exist and have the correct geoms and aesthetics.

## How to run locally

1. Install R (version 4.2 or newer recommended).[web:14]  
2. Install required packages in R:

   ```r
   install.packages("ggplot2")
   install.packages("testthat")
   ```

3. Open this folder in RStudio or run in a terminal:

   ```r
   source("solution.R")
   library(testthat)
   testthat::test_dir("tests/testthat")
   ```

If all tests pass, your submission will also pass in GitHub Classroom.

## Submission guidelines

- Do not change file names: keep `solution.R` and the `tests/` folder as provided.
- Do not rename the plot objects (`plot1`, `plot2`, `plot3`, `plot4`).
- You may add comments in `solution.R`, but do not remove or overwrite the required plot code.
