## Getting and Cleaning Data Project

This script assumes that the Data is located in the working directory.

The script requires the installation of the package "reshape2"

Once executed creates the file "tidyData.txt"
 
Assumptions taken into account with the data proccessing:
* Created column names for the activity and subject data are: Activity, Subject.
* Preserved variables that include mean and std have been selected with: "[Mm]ean|[Ss]td|Activity|Subject" pattern
* The final tidy dataset groups every activity and breaks it by subject.