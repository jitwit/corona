.PHONY: clean update

# thank you to $(covidcanrepo) for dealing with this madness
deaths_url = https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv
confirmed_url = https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv
inspq_url = https://www.inspq.qc.ca/sites/default/files/covid/donnees/combine.csv
deaths.csv = ~/code/corona/data/deaths.csv
confirmed.csv = ~/code/corona/data/confirmed.csv
inspq.csv = ~/code/corona/data/inspq.csv

covcanrepo = ../Covid19Canada

update : 
	cd $(covcanrepo) && git pull

README.html : README.org
	emacs $< --batch --eval "(org-html-export-to-html)"

clean :
	rm -rf *~ *.html
