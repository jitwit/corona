.PHONY: clean update-repo updates.txt rona

# thank you to $(covidcanrepo) for dealing with this madness
deaths_url = https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv
confirmed_url = https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv
inspq_url = https://www.inspq.qc.ca/sites/default/files/covid/donnees/combine.csv
deaths.csv = ~/code/corona/data/deaths.csv
confirmed.csv = ~/code/corona/data/confirmed.csv
inspq.csv = ~/code/corona/data/inspq.csv

covcanrepo = ../Covid19Canada

rona : README.html
	xdg-open $<

update-repo : 
	cd $(covcanrepo) && git pull

README.html : README.org update-repo
	emacs $< --batch -f org-html-export-to-html

clean :
	rm -rf *~ *.html

updates.txt :
	cd $(covcanrepo) && git log | grep "Date:" | cut -d ' ' -f 5,6,7,8 > ../corona/updates.txt 
