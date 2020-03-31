require'tables/csv plot web/gethttp'

gov_cases_url=: 'https://health-infobase.canada.ca/src/data/covidLive/covid19.csv'

deaths_url=: 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv'
confirmed_url=: 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv'

update_cases=: monad define
'-o data/cases.csv' gethttp gov_cases_url
)

update_confirmed=: monad define
'-o data/confirmed.csv' gethttp confirmed_url
)

update_deaths=: monad define
'-o data/deaths.csv' gethttp deaths_url
)

update=: update_cases@update_confirmed@update_deaths
