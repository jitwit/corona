confirmed=: makenum &.> readcsv jpath '~/code/corona/data/confirmed.csv'
deaths   =: makenum &.> readcsv jpath '~/code/corona/data/deaths.csv'
CAN=: I.(<'Canada')e.~1{::"1 confirmed

NB. gov ca. unevenly updated data...
cases    =: makenum &.> readcsv jpath '~/code/corona/data/cases.csv'
NB. retiring
NB. qc_cases =: > 4 {"1] 4 {:: (</.~ {."1) cases

growth    =: 2 ({.%~-~/)\ (#~0&<)
avg_growth=: (+/%#)\ growth f.
regress   =: (%. 1 ,. i.@#) @: ^.

NB. plot settings/customization
CLRS_z_=: |. 0 114 255 , 27 240 141 , 0 127 132 , 88 83 176 ,: 136 103 176

CAN_FORM=: noun define
reset;
backcolor black;frame 1;xcaption Days;ycaption Infected;
backcolor 0 0 0;labelcolor 243 240 207; captioncolor 243 240 207;
axiscolor 243 240 207; textcolor 243 240 207; titlecolor 243 240 207;
itemcolor CLRS; pensize 2;
)

NB. plots
plot_confirmed=: monad define
pd CAN_FORM
pd 'title Coronavirus confirmed in CANADA'
pd _28 {."1 > 4}."1 confirmed{~0 1 7 9 10{CAN
pd 'key Alberta "British Columbia" Ontario Québec Saskatchewan;show'
)

plot_deaths=: monad define
pd CAN_FORM
pd 'title Coronavirus death in CANADA'
pd _28 {."1 > 4}."1 deaths{~0 1 7 9 10{CAN
pd 'key Alberta "British Columbia" Ontario Québec Saskatchewan;show'
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