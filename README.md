## Mishegyan's Repository Guide

### _Week 2's Assignment Purpose:_
&nbsp; The purpose of this guide is to help your understand how to format your repository like mine.

### _Part 1 - Proper project file structure:_
&nbsp; Your file structure should look something like this:
* project name
  * data
  * output
  * scripts

### _Part 2 - Writing your first script:_
&nbsp; You will want to begin by starting a new scripts file (ie. .R file) in your scripts folder. Then start your script with a header. This will provide the reader info about purpose of the script, who created the script, when it was created and updated in iso format (YYYY-MM-DD), etc.  
&nbsp; In order to write your header, you must include at least one "#" to add it as a comment for every comment line. Additionaly, include a space after each "#" to make it easier on the reader. After this part is complete, move onto part 3.  
Here is an example of how it should look:  
"### This is my first script. I am learning how to import data"  
"### Created by: Avetis Mishegyan"  
"### Created on: 2023-02-06"  
"###############################################"

### _Part 3 - Loading necessary libraries (ie. packages):_
&nbsp; Start by making another header to indicate the libraries being loaded. Then install necessary pakages by typing "**install.packages("PackageName")**" **into the console**. Then in order to load your necessary libraries by typing out **"library(PackageName)."** However, the later parts require a package known as "here" which helps us easily navigate around our projects (ie. makes our data available for analysis with other tools).  
Here is an example of how it should look:  
"### Load libraries ##########"  
"library(tidyverse)"

### _Part 4 - How to read data from data folder for your scripts file (ie. csv files):_
