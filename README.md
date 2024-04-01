README
================

This repository contains the files needed to render
`midterm_project_report.html`. It contains a hierarchically ordered set
of `code` folders, a folder wit hthe raw data set
`wastewater_feb25.csv.zip`, a folder with the clean data set
`wastewater_clean.csv`, a folder with the code output, the RMarkdown
file `midterm_project_report.Rmd` and its associated .html file, a
.gitignore file, and a Makefile that contains GNU Make commands for
rendering the report and its components. Briefly, this analysis provides
the descriptive epidemiology of SARS-CoV-2 surveillance in the United
States by US region from 2020-2024.

# Instructions for generating the report

You will need RStudio, bash, and GNU Make to render this report as
intended.

1.  Clone the data_550_midterm_project repository from GtiHub to a local
    directory.
2.  Navigate to the cloned repository. Set this as your working
    directory.
3.  Type the command make in the RStudio terminal with a bash shell to
    create the components of the report and compile
    midterm_project_report.html in your local final_project directory.
    Alternatively, open the Makefile to see what make commands are
    available generating individual components of the report.  
    **NOTE:** remove the rendered .html report and all files in the
    output folder with the command make clean.

# Customization

# Code directory

Code for creating the tables and figure are found in the code folder:

- code/coder_1/01_clean_data.R: imports raw data, selects key variables,
  calculates mean by month, creates US region variable, recodes missing
  data (i.e., 999 –\> NA)
- code/coder_1/02_render.R: renders the html report
  midterm_project_report.html
- code/coder_2/01_make_desc_table.R: imports clean data, calculates
  summary statistics, creates kable table, saves kable table object
- code/coder_3/01_bargraph.R: imports clean data, creates ggplot bar
  graph, saves png
- code/coder_4/01_line_graph.R: imports clean data, calculates summary
  statistics, creates ggplot bar line graph, saves png
- code/coder_5/01_gis_map.R: imports clean data, calculates summary
  statistics, creates GIS plot, saves png
