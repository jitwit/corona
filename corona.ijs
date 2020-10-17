load 'tables/csv plot'
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
cpup =: 1000

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
if. IFQT do. pd 'qt 1200 800' end.
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
if. IFQT do. pd 'show; save png /home/jrn/code/corona/images/cases'
else. pd 'show' end.
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

NB. plot settings/customization
NB. maybe look to?: https://code.jsoftware.com/wiki/Scripts/Real-time_Plot
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
bin z; pshow;
)

rona_close=: 3 : 0
wd'psel rona;pclose'
)

rona_fetch_button=: update
rona_pdeaths_button=: plot_d
rona_pcases_button=: plot_c
rona_maw_button=: 3 : 0
WINDOW=: ". wd 'get maw text'
)
rona_tmf_button=: 3 : 0
tf=: ". wd 'get tmf text'
)

courir=: 3 : 0
if. IFQT do.
  rona_close^:(wdisparent'rona')''
  wd rona_form
else. plot_c'' end.
)

courir''
