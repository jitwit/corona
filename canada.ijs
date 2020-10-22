require 'tables/csv plot'
DIR=: '~/code/corona'

pop_provs=: 'Ontario';'Quebec';'BC';'Alberta';'Manitoba';'Saskatchewan';'Nova Scotia';'New Brunswick';'NL';'PEI';'NWT';'Nunavut';'Yukon'
pop_pops =: 14745040 8552362 5120184 4428247 1379121 1181987 978274 780890 520437 158717 44982 39486 41293

update=: 3 : 0
echo 2!:0 'cd ',DIR,' && make update'
echo 'updated'
)

csv =: makenum &.> readcsv jpath '~/code/corona/data/inspq.csv'
hdrs =: {. csv

csv_t=: readcsv '~/code/Covid19Canada/timeseries_prov/testing_timeseries_prov.csv'
csv_c=: readcsv '~/code/Covid19Canada/timeseries_prov/cases_timeseries_prov.csv'
csv_d=: readcsv '~/code/Covid19Canada/timeseries_prov/mortality_timeseries_prov.csv'

tf =: 7
cpup =: 1000000

plot_prov =: 3 : 0
'csv prov clr' =. y
dts =. ~. }. 1 {"1 csv
pop =. pop_pops {~ pop_provs i. < prov
ts =. cpup * pop %~ > _2 {"1 makenum &.> csv #~ prov&-: &> {."1 csv
pd 'color ',clr,';type dot; pensize 0.8'
pd (;~i.@#) ts
pd 'type line;pensize 2'
pd (;~(-:tf)+i.@#) tf (+/%#)\ ts
)

plot_c =: 3 : 0
dir=. 1!:43''
1!:44 jpath DIR,'/images'
pd 'reset'
pd 'xcaption days; ycaption cases/',(":cpup),'; title rona cases in canada'
pd 'subtitle daily report & ',(":tf),' day moving average; subtitlecolor snow'
pd 'backcolor black; labelcolor snow; captioncolor snow; titlecolor snow'
pd 'axiscolor snow; labelcolor snow; captioncolor snow'
plot_prov csv_c;'Quebec';'21 199 255'
plot_prov csv_c;'Ontario';'250 40 66'
plot_prov csv_c;'Alberta';'15 217 39'
plot_prov csv_c;'BC';'130 113 204'
plot_prov csv_c;'Manitoba';'221 113 167'
pd 'key Québec Ontario Alberta "British Columbia" Manitoba'
pd 'keycolor 21 199 255,250 40 66,15 217 39,130 113 204,221 113 167'
if. IFQT do. pd 'show canvas 1200 800 /home/jrn/code/corona/images/cases' end.
1!:44 dir
)

plot_d =: 3 : 0
dir=. 1!:43''
1!:44 jpath DIR,'/images'
pd 'reset'
if. IFQT do. pd 'qt 1200 800' end.
pd 'xcaption days; ycaption deaths/',(":cpup),'; title rona deaths in canada'
pd 'subtitle daily report & ',(":tf),' day moving average; subtitlecolor snow'
pd 'backcolor black; labelcolor snow; captioncolor snow; titlecolor snow'
pd 'axiscolor snow; labelcolor snow; captioncolor snow'
plot_prov csv_d;'Quebec';'21 199 255'
plot_prov csv_d;'Ontario';'250 40 66'
plot_prov csv_d;'Alberta';'15 217 39'
plot_prov csv_d;'BC';'130 113 204'
plot_prov csv_d;'Manitoba';'221 113 167'
pd 'key Québec Ontario Alberta "British Columbia" Manitoba'
pd 'keycolor 21 199 255,250 40 66,15 217 39,130 113 204,221 113 167'
if. IFQT do. pd 'show; save png /home/jrn/code/corona/images/death'
else. pd 'show' end.
1!:44 dir
)


plot_c''
