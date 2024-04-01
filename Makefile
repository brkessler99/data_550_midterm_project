midterm_project_report.html: midterm_project_report.rmd code/coder_1/02_render.R output/desc_table.Rds output/bargraph.png output/figure_three.png output/us_plot.png
	Rscript code/coder_1/02_render.R

clean_data/wastewater_clean.csv: code/coder_1/01_clean_data.R raw_data/wastewater_feb25.csv.zip
	Rscript code/coder_1/01_clean_data.R
	
output/desc_table.Rds: code/coder_2/01_make_desc_table.R clean_data/wastewater_clean.csv
	Rscript code/coder_2/01_make_desc_table.R
	
output/bargraph.png: code/coder_3/02_bargraph.R clean_data/wastewater_clean.csv
	Rscript code/coder_3/02_bargraph.R
	
output/figure_three.png: code/coder_4/01_line_graph.R clean_data/wastewater_clean.csv
	Rscript code/coder_4/01_line_graph.R

output/us_plot.png: code/coder_5/gis_map.R clean_data/wastewater_clean.csv
	Rscript code/coder_5/gis_map.R

.PHONY: clean
clean:
	rm -f output/* && rm -f report.html