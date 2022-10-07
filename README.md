# Data_Cleaning_with_SQL

Dataset Cleaning with MYSQL

This Project focuses on cleaning a Nashville housing dataset.
The cleaning procedure is as follows

	1. Standerdizing the date. The date column is in string and 
	    also not formatted properly. 
	2. The property address column is a combination of street,city, state
      Formatting was done by spliting this into its components which are
	    street, city and state
	3. The owner address column is also improperly formatted and it needed to 
	    be split into its components
	4. The sold as vacant column is a boolean and formatted as "Y" and "N"
	    It was formatted to "Yes" and "No" 
	5. Unused columns were dropped.
  
 The dataset contains about 56,000 rows and about 26 columns

Dependencies
MYSQL workbench

Author
This cleaning was done by Etuonu David

Acknowledgement
Inspiration from Alex Frieberg
