To use run_analysis.R :

Preparation

1. Ensure you have already downloaded and unzipped the data file.

2. Ensure R's setwd() already is set just inside the UCI HAR Dataset directory.

Execution

3. source run_analysis.R

Output

4. Several variables will be added to your R workspace.  See the explanation of the cleanup process, in codes.md, for details on how those relate to each stage of the data cleanup.

5. The file averages.txt will be generated on disk automatically.  This is the primary result of running the script, and contains the means (per subject per activity) of the mean and standard deviation measurements in the original data.

6. As a side effect, the file fields.txt will be generated on disk automatically, with a list of the field names from the averages file.  This was merely used to start the codes.md file (the rest done by hand).

