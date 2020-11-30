require 'plot data/jsv'

csv_p =: rcsv '~/code/Covid19Canada/other/prov_map.csv'
csv_t =: rcsv '~/code/Covid19Canada/timeseries_prov/testing_timeseries_prov.csv'
csv_c =: rcsv '~/code/Covid19Canada/timeseries_prov/cases_timeseries_prov.csv'
csv_d =: rcsv '~/code/Covid19Canada/timeseries_prov/mortality_timeseries_prov.csv'

sel =: {{ (1,({.y)i.<x){::y }}
provs =: 'province' sel csv_p
pops =: _".'pop' sel csv_p
msk =: {{ x -:"1 (#x) {."1 y }}"1

plot_prov =: 3 : 0
'csv prov clr' =. y
pop =. pops {~ (}. i. {.) prov,provs
js =. prov msk 'province' sel csv
ts =. perpop * pop %~ 0 ". js # 1 _2 {:: csv NB. cases/deaths it's column _2
pd 'color ',clr,';type dot;pensize 0.6'
pd (;~i.@#) ts
pd 'type line;pensize 2.4'
pd (;~(-:tf)+i.@#) tf (+/%#)\ ts
)

plot_c =: 3 : 0
pd 'reset'
pd 'xcaption days; ycaption cases/',(":perpop),'; title rona cases in canada'
pd 'subtitle daily report & ',(":tf),' day moving average; subtitlecolor snow'
pd 'backcolor black; labelcolor snow; captioncolor snow; titlecolor snow'
pd 'axiscolor snow; labelcolor snow; captioncolor snow'
plot_prov csv_c;'Quebec';'21 199 255'
plot_prov csv_c;'Ontario';'250 40 66'
plot_prov csv_c;'Alberta';'15 217 39'
plot_prov csv_c;'BC';'130 113 204'
plot_prov csv_c;'Manitoba';'221 113 167'
plot_prov csv_c;'Saskatchewan';'253 140 75'
pd 'key Québec Ontario Alberta "British Columbia" Manitoba Saskatchewan'
pd 'keycolor 21 199 255,250 40 66,15 217 39,130 113 204,221 113 167,253 140 75'
pd 'visible 0; show'
)

plot_d =: 3 : 0
pd 'reset'
pd 'xcaption days; ycaption deaths/',(":perpop),'; title rona deaths in canada'
pd 'subtitle daily report & ',(":tf),' day moving average; subtitlecolor snow'
pd 'backcolor black; labelcolor snow; captioncolor snow; titlecolor snow'
pd 'axiscolor snow; labelcolor snow; captioncolor snow'
plot_prov csv_d;'Quebec';'21 199 255'
plot_prov csv_d;'Ontario';'250 40 66'
plot_prov csv_d;'Alberta';'15 217 39'
plot_prov csv_d;'BC';'130 113 204'
plot_prov csv_d;'Manitoba';'221 113 167'
plot_prov csv_d;'Saskatchewan';'253 140 75'
pd 'key Québec Ontario Alberta "British Columbia" Manitoba Saskatchewan'
pd 'keycolor 21 199 255,250 40 66,15 217 39,130 113 204,221 113 167,253 140 75'
pd 'visible 0; show'
)

tf =: 7
perpop =: 10^6
plot_c ''
