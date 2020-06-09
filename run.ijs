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
CLRS_z_=: |. 0 114 255 , 27 240 141 , 0 127 132 , 88 83 176 ,: 136 103 176
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
