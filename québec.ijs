coclass 'jqrona'

require'tables/csv plot web/gethttp stats/base'

dirtree '../Covid19Canada'
csv =: makenum &.> readcsv jpath '~/code/corona/data/inspq.csv'
hdrs =: {. csv
colconf =: 'Cumul de cas confirmés'
colneg  =: 'Cumul des personnes avec des analyses négatives'
coltest =: 'Personnes testées'

colscd   =: hdrs i. <&.> 'Nouveaux cas';'Nouveaux décès'
colstest =: hdrs i. <&.> colconf;colneg NB. ;coltest

qcresults  =: > }. colstest {"1 csv
qcprogress =: > 2 }. colscd {"1 csv

NB. moving positive test rate
mptr =: 3 : '%/"1 y ({:-{.)\ +/\"1 qcresults'

csv_t=: readcsv '../Covid19Canada/timeseries_prov/testing_timeseries_prov.csv'
csv_c=: readcsv '../Covid19Canada/timeseries_prov/cases_timeseries_prov.csv'
csv_d=: readcsv '../Covid19Canada/timeseries_prov/mortality_timeseries_prov.csv'

qc_d=: csv_d #~ 'Quebec'&-: &> {."1 csv_d
on_d=: csv_d #~ 'Ontario'&-: &> {."1 csv_d
al_d=: csv_d #~ 'Alberta'&-: &> {."1 csv_d

qc_c=: csv_c #~ 'Quebec'&-: &> {."1 csv_c
on_c=: csv_c #~ 'Ontario'&-: &> {."1 csv_c
al_c=: csv_c #~ 'Alberta'&-: &> {."1 csv_c

qc_c_ts=: > _2 {"1 makenum &.> qc_c
on_c_ts=: > _2 {"1 makenum &.> on_c
al_c_ts=: > _2 {"1 makenum &.> al_c

qc_d_ts=: > _2 {"1 makenum &.> qc_d
on_d_ts=: > _2 {"1 makenum &.> on_d
al_d_ts=: > _2 {"1 makenum &.> al_d

tf =: 10

plot_c =: 3 : 0
pd 'reset; xcaption days; ycaption cases; title rona cases in canada'
pd 'subtitle daily report & 10 day moving average; subtitlecolor snow'
pd 'backcolor black; labelcolor snow; captioncolor snow; titlecolor snow'
pd 'axiscolor snow; labelcolor snow; captioncolor snow'
pd 'color blue;type dot;pensize 0.5'
pd (;~i.@#) qc_c_ts
pd 'type line;pensize 2'
pd (;~(-:tf)+i.@#) tf (+/%#)\ qc_c_ts
pd 'color red;type dot;pensize 0.5'
pd (;~i.@#) on_c_ts
pd 'type line;pensize 2'
pd (;~(-:tf)+i.@#) tf (+/%#)\ on_c_ts
pd 'color green;type dot;pensize 0.5'
pd (;~i.@#) al_c_ts
pd 'type line;pensize 2'
pd (;~(-:tf)+i.@#) tf (+/%#)\ al_c_ts
pd 'key Québec Ontario Alberta; keycolor blue,red,green'
pd 'show'
)

plot_d =: 3 : 0
pd 'reset; xcaption days; ycaption cases; title rona deaths in canada'
pd 'subtitle daily report & 10 day moving average; subtitlecolor snow'
pd 'backcolor black; labelcolor snow; captioncolor snow; titlecolor snow'
pd 'axiscolor snow; labelcolor snow; captioncolor snow'
pd 'color blue;type dot;pensize 0.5'
pd (;~i.@#) qc_d_ts
pd 'type line;pensize 2'
pd (;~(-:tf)+i.@#) tf (+/%#)\ qc_d_ts
pd 'color red;type dot;pensize 0.5'
pd (;~i.@#) on_d_ts
pd 'type line;pensize 2'
pd (;~(-:tf)+i.@#) tf (+/%#)\ on_d_ts
pd 'color green;type dot;pensize 0.5'
pd (;~i.@#) al_d_ts
pd 'type line;pensize 2'
pd (;~(-:tf)+i.@#) tf (+/%#)\ al_d_ts
pd 'key Québec Ontario Alberta; keycolor blue,red,green'
pd 'show pdf'
)

plot_d''