report.html: midterm_project_report.rmd code/coder_1/02_render.R clean_data table graph_bar graph_line graph_gis
	Rscript code/coder_1/02_render.R

clean_data/wastewater_clean.csv: code/coder_1/01_clean_data.R raw_data/wastewater_feb25.csv.zip
	Rscript code/coder_1/01_clean_data.R
	
table:
	Rscript code/coder_2/01_make_desc_table.R
	
graph_bar:
	Rscript code/coder_3/02_bargraph.R
	
graph_line:
	Rscript code/coder_4/01_line_graph.R

graph_gis:
	Rscript code/coder_5/gis_map.R

.PHONY: clean
clean:
	rm -f output/*.rds && rm -f report.html