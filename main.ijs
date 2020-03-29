require'tables/csv plot web/gethttp'
NB. hopkins
confirmed=: makenum &.> readcsv jpath '~/code/corona/data/confirmed.csv'
deaths   =: makenum &.> readcsv jpath '~/code/corona/data/deaths.csv'

NB. gov ca.... apparently incorrect data, jeez
cases    =: makenum &.> readcsv jpath '~/code/corona/data/cases.csv'


qc_cases =: > 4 {"1] 4 {:: (</.~ {."1) cases
on_cases =: > 4 {"1] 1 {:: (</.~ {."1) cases

CAN=: I.(<'Canada')e.~1{::"1 confirmed
AL =: > 4 }. 36 { confirmed
BC =: > 4 }. 37 { confirmed
ON =: > 4 }. 43 { confirmed
QC =: > 4 }. 45 { confirmed

growth    =: 2 ({.%~-~/)\ (#~0&<)
avg_growth=: (+/%#)\ growth
regress   =: (%. 1 ,. i.@#) @: ^.

CLRS_z_=: |. 0 114 255 , 27 240 141 , 0 127 132 , 88 83 176 ,: 136 103 176

CAN_FORM=: noun define
reset;title Coronavirus in CANADA;
backcolor black;frame 1;xcaption Days;ycaption Infected;
backcolor 0 0 0;labelcolor 243 240 207; captioncolor 243 240 207;
axiscolor 243 240 207; textcolor 243 240 207; titlecolor 243 240 207;
itemcolor CLRS; pensize 2;
)

plot_confirmed=: monad define
pd CAN_FORM
pd _28 {."1 > 4}."1 confirmed{~0 1 7 9 10{CAN
pd'key Alberta "British Columbia" Ontario Québec Saskatchewan;show'
)

predict=: dyad define
pd CAN_FORM
pd 'type dot'
pd y
pd 'type line; itemcolor 27 240 141'
echo 'a*e^b';;/]aec=. regress y
pd 0 >. ^ aec p. (i.x+#y)
pd 'show'
)

plot_confirmed ^: IFQT ''