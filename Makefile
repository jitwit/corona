.PHONY: clean update

deaths_url = https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv
confirmed_url = https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv
inspq_url = https://www.inspq.qc.ca/sites/default/files/covid/donnees/combine.csv
deaths.csv = ~/code/corona/data/deaths.csv
confirmed.csv = ~/code/corona/data/confirmed.csv
inspq.csv = ~/code/corona/data/inspq.csv
covcanrepo = ../Covid19Canada

update : 
	curl $(confirmed_url) > $(confirmed.csv)
	curl $(deaths_url) > $(deaths.csv)
#	curl $(inspq_url) > $(inspq.csv) unreliable clowns
	cd $(covcanrepo) && git pull

clean :
	rm -rf *~
