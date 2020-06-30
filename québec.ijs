coclass 'jqrona'

require'tables/csv plot web/gethttp'
csv =: makenum &.> readcsv jpath '~/code/corona/data/inspq.csv'
hdrs =: {. csv
colconf =: 'Cumul de cas confirmés'
colneg  =: 'Cumul des personnes avec des analyses négatives'
coltest =: 'Personnes testées'

testcols =: hdrs i. colconf (,&(<^:2)) coltest
qctests  =: > }. testcols {"1 csv

newtests =: 2 -~/\ qctests

NB. moving positive test rate
mptr =: 3 : '%/"1 y ({:-{.)\ qctests'