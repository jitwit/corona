coclass 'jqrona'

require'tables/csv plot web/gethttp stats/base'
csv =: makenum &.> readcsv jpath '~/code/corona/data/inspq.csv'
hdrs =: {. csv
colconf =: 'Cumul de cas confirmés'
colneg  =: 'Cumul des personnes avec des analyses négatives'
coltest =: 'Personnes testées'
hdrstest =: < &.> colconf;colneg;coltest
testcols =: hdrs i. 0 1 { hdrstest
qcresults  =: > }. testcols {"1 csv

NB. newtests =: 2 -~/\ qctests

NB. moving positive test rate
mptr =: 3 : '%/"1 y ({:-{.)\ qcresults'
