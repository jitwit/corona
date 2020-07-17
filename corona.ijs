coclass'jrona'
require'tables/csv plot web/gethttp jzplot'

confirmed=: makenum &.> readcsv jpath '~/code/corona/data/confirmed.csv'
deaths   =: makenum &.> readcsv jpath '~/code/corona/data/deaths.csv'
CAN      =: I.(<'Canada')e.~1{::"1 confirmed
DIR=: '~/code/corona'

update=: 3 : 0
echo 2!:0 'cd ',DIR,' && make update'
echo 'updated'
confirmed=: makenum &.> readcsv jpath '~/code/corona/data/confirmed.csv'
deaths   =: makenum &.> readcsv jpath '~/code/corona/data/deaths.csv'
)

growth      =: ({:-{.)\ (#~0&<)
regress     =: (%.1,.i.@#)@:^.
rixes       =: [:I.(>1{"1 confirmed)=<
documented  =: (<"0 ,. {&confirmed) & rixes
dead        =: (<"0 ,. {&deaths) & rixes

WINDOW=: 7
TIMEFRAME=: _120
]QCC=: TIMEFRAME{.>4}.45{confirmed
]ONC=: TIMEFRAME{.>4}.43{confirmed
]OND=: TIMEFRAME{.>4}.43{deaths
]QCD=: TIMEFRAME{.>4}.45{deaths

NB. plot settings/customization
NB. maybe look to?: https://code.jsoftware.com/wiki/Scripts/Real-time_Plot
CLRS_z_=: 0 127 132, 136 103 176,27 240 141,0 114 255,: 88 83 176
CAN_FORM=: 0 : 0
reset; qt 1200 800;
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
pd 'key Alberta "British Columbia" Ontario Québec Saskatchewan'
)

plot_deaths=: 3 : 0
pd CAN_FORM
pd'xcaption Days;ycaption Dead;'
pd 'title Coronavirus death in CANADA'
pd WINDOW %~ WINDOW growth"1 ] TIMEFRAME {."1 > 4}."1 deaths{~0 1 7 9 10{CAN
pd 'key Alberta "British Columbia" Ontario Québec Saskatchewan'
)

rona_form=: 0 : 0
pc rona; pn "J rona";
bin h;
  bin v;
    cc pdeaths button; set pdeaths caption "show deaths";
    cc pcases  button; set pcases  caption "show cases";
    bin h;
      cc mawlab static; cn "sliding avg size";
      cc maw edit; set maw wh 30 20; set maw regexpvalidator \d{,2}; set maw text 7;
    bin z;
    bin h;
      cc tmflab static; cn "timeframe size";
      cc tmf edit; set tmf wh 30 20; set tmf regexpvalidator \d{,3}; set tmf text 120;
    bin z;
    cc fetch button; set fetch caption update;
  bin z;
bin z;
pshow;
)

rona_close=: 3 : 0
wd'psel rona;pclose'
)

rona_fetch_button=: update
rona_pdeaths_button=: plot_deaths
rona_pcases_button=: plot_confirmed
rona_maw_button=: 3 : 0
WINDOW=: ". wd 'get maw text'
)
rona_tmf_button=: 3 : 0
TIMEFRAME=: - ". wd 'get tmf text'
)

courir=: 3 : 0
if. IFQT do. wd rona_form[rona_close^:(wdisparent'rona')''
else. 'wants to be run from jqt' end.
)

courir''