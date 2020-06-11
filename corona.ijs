require'tables/csv plot web/gethttp'

donnees_url=: 'https://www.inspq.qc.ca/covid-19/donnees'
gov_cases_url=: 'https://health-infobase.canada.ca/src/data/covidLive/covid19.csv'

deaths_url=: 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv'
confirmed_url=: 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv'

update_cases=: monad define
echo gov_cases_url
'-o ~/code/corona/data/cases.csv' gethttp gov_cases_url
)

update_donnees=: monad define
echo donnees_url
'-o ~/code/corona/data/donnees.csv' gethttp donnees_url
)

update_confirmed=: monad define
echo confirmed_url
'-o ~/code/corona/data/confirmed.csv' gethttp confirmed_url
)	

update_deaths=: monad define
echo deaths_url
'-o ~/code/corona/data/deaths.csv' gethttp deaths_url
)

update=: update_donnees@update_cases@update_confirmed@update_deaths

confirmed=: makenum &.> readcsv jpath '~/code/corona/data/confirmed.csv'
deaths   =: makenum &.> readcsv jpath '~/code/corona/data/deaths.csv'
CAN      =: I.(<'Canada')e.~1{::"1 confirmed

growth      =: ({:-{.)\ (#~0&<)
avg_growth  =: (+/%#)\ growth
regress     =: (%.1,.i.@#)@:^.
rixes       =: [:I.(>1{"1 confirmed)=<
documented  =: (<"0 ,. {&confirmed) & rixes
dead        =: (<"0 ,. {&deaths) & rixes

WINDOW=: 7
TIMEFRAME=: _60
]QCC=: TIMEFRAME{.>4}.45{confirmed
]ONC=: TIMEFRAME{.>4}.43{confirmed
]OND=: TIMEFRAME{.>4}.43{deaths
]QCD=: TIMEFRAME{.>4}.45{deaths

NB. plot settings/customization
CLRS_z_=: 0 114 255, 136 103 176, 0 127 132 , 88 83 176 ,: 27 240 141
CAN_FORM=: 0 : 0
reset;
backcolor black;frame 1;
backcolor 0 0 0;labelcolor 243 240 207; captioncolor 243 240 207;
axiscolor 243 240 207; textcolor 243 240 207; titlecolor 243 240 207;
itemcolor CLRS; pensize 2;
)

plot_confirmed=: 3 : 0
pd CAN_FORM
pd'xcaption Days;ycaption Newly Infected;'
pd 'title Coronavirus confirmed in CANADA'
pd WINDOW %~ WINDOW growth"1 ] TIMEFRAME {."1 > 4}."1 confirmed{~0 1 7 9 10{CAN
pd 'key Alberta "British Columbia" Ontario Québec Saskatchewan;show'
)

plot_deaths=: 3 : 0
pd CAN_FORM
pd'xcaption Days;ycaption Dead;'
pd 'title Coronavirus death in CANADA'
pd WINDOW %~ WINDOW growth"1 ] TIMEFRAME {."1 > 4}."1 deaths{~0 1 7 9 10{CAN
pd 'key Alberta "British Columbia" Ontario Québec Saskatchewan;show'
)

reloadit=: 3 : 0
'a b'=. 2{.(>y),WINDOW,TIMEFRAME
load'run.ijs'
WINDOW=: a
TIMEFRAME=: b
plot_deaths ^: IFQT ''
)

rona_form=: 0 : 0
pc rona; pn "J rona";
bin v;
  cc fetch button; set fetch caption update;
  cc pdeaths button; set pdeaths caption "show deaths";
  cc pcases  button; set pcases  caption "show cases";
bin z;
pshow;
)

rona_close=: 3 : 0
wd'psel rona;pclose'
)

rona_fetch_button=: update
rona_pdeaths_button=: plot_deaths
rona_pcases_button=: plot_confirmed

courir=: 3 : 0
if. IFQT do. wd rona_form[rona_close^:(wdisparent'rona')''
else. echo 'wants to be run from jqt' end.
)

courir''