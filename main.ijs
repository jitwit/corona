require'tables/csv plot web/gethttp'

update_confirmed=: monad define
url=. 'https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv'
'-o data/confirmed.csv' gethttp url
)

confirmed=: makenum &.> readcsv jpath '~/code/corona/data/confirmed.csv'

CAN=: I.(<'Canada')e.~1{::"1 confirmed

growth=: 2 ({. %~ -~/)\ (#~0&<)
regress=: (%. 1 ,. i.@#) @: ^.

CLRS_z_=: |. 0 114 255 , 27 240 141 , 0 127 132 , 88 83 176 ,: 136 103 176

CAN_FORM=: noun define
reset;title Coronavirus in CANADA;
backcolor black;frame 1;xcaption Days;ycaption Infected;
backcolor 0 0 0;labelcolor 243 240 207; captioncolor 243 240 207;
axiscolor 243 240 207; textcolor 243 240 207; titlecolor 243 240 207;
itemcolor CLRS; pensize 2;
)

plot_canada=: monad define
pd CAN_FORM
pd _28 {."1 > 4}."1 confirmed{~0 2 7 9 10{CAN
pd'key al bc on qc sa;show'
)

NB. x is number of days to predict, y is index of region
predict=: dyad define
y=. (}.~ 1 I.~ 0 < ]) > 4}. y{confirmed
pd CAN_FORM
pd 'type dot'
pd y
pd 'type line; itemcolor 27 240 141'
pd 0 >. ^ (regress y) p. (i.x+#y)
pd 'show'
)

plot_canada ^: IFQT ''
NB. 7 predict ^: IFQT 45