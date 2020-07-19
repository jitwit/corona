require'tables/csv plot web/gethttp jzplot media/imagekit'
coinsert 'pplatimg jwplot'

DIR=: '~/code/corona'

update=: 3 : 0
echo 2!:0 'cd ',DIR,' && make update'
echo 'updated'
)

csv =: makenum &.> readcsv jpath '~/code/corona/data/inspq.csv'
hdrs =: {. csv
colconf =: 'Cumul de cas confirmés'
colneg  =: 'Cumul des personnes avec des analyses négatives'
coltest =: 'Personnes testées'

colscd   =: hdrs i. <&.> 'Nouveaux cas';'Nouveaux décès'
colstest =: hdrs i. <&.> colconf;colneg NB. ;coltest

qcresults  =: > }. colstest {"1 csv
qcprogress =: > 2 }. colscd {"1 csv

csv_t=: readcsv '~/code/Covid19Canada/timeseries_prov/testing_timeseries_prov.csv'
csv_c=: readcsv '~/code/Covid19Canada/timeseries_prov/cases_timeseries_prov.csv'
csv_d=: readcsv '~/code/Covid19Canada/timeseries_prov/mortality_timeseries_prov.csv'

tf =: 7

plot_prov =: 3 : 0
'csv prov clr' =. y
ts =. > _2 {"1 makenum &.> csv #~ prov&-: &> {."1 csv
pd 'color ',clr,';type dot; pensize 0.8'
pd (;~i.@#) ts
pd 'type line;pensize 2'
pd (;~(-:tf)+i.@#) tf (+/%#)\ ts
)

plot_c =: 3 : 0
dir=. 1!:43''
1!:44 jpath DIR,'/images'
pd 'reset'
if. IFQT do. pd 'qt 1200 800' end.
pd 'xcaption days; ycaption cases; title rona cases in canada'
pd 'subtitle daily report & ',(":tf),' day moving average; subtitlecolor snow'
pd 'backcolor black; labelcolor snow; captioncolor snow; titlecolor snow'
pd 'axiscolor snow; labelcolor snow; captioncolor snow'
plot_prov csv_c;'Quebec';'21 199 255'
plot_prov csv_c;'Ontario';'250 40 66'
plot_prov csv_c;'Alberta';'15 217 39'
plot_prov csv_c;'BC';'130 113 204'
pd 'key Québec Ontario Alberta "British Columbia"'
pd 'keycolor 21 199 255,250 40 66,15 217 39,130 113 204'
if. IFQT do. pd 'show; save png cases.png 0'
else. pd 'show' end.
1!:44 dir
)

plot_d =: 3 : 0
dir=. 1!:43''
1!:44 jpath DIR,'/images'
pd 'reset'
if. IFQT do. pd 'qt 1200 800' end.
pd 'xcaption days; ycaption cases; title rona deaths in canada'
pd 'subtitle daily report & ',(":tf),' day moving average; subtitlecolor snow'
pd 'backcolor black; labelcolor snow; captioncolor snow; titlecolor snow'
pd 'axiscolor snow; labelcolor snow; captioncolor snow'
plot_prov csv_d;'Quebec';'21 199 255'
plot_prov csv_d;'Ontario';'250 40 66'
plot_prov csv_d;'Alberta';'15 217 39'
plot_prov csv_d;'BC';'130 113 204'
pd 'key Québec Ontario Alberta "British Columbia"'
pd 'keycolor 21 199 255,250 40 66,15 217 39,130 113 204'
if. IFQT do. pd 'show; save png death.png 0'
else. pd 'show' end.
1!:44 dir
)
