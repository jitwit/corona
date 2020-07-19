load '~/code/corona/québec.ijs'

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
TIMEFRAME=: - ". wd 'get tmf text'
)

courir=: 3 : 0
if. IFQT do.
  rona_close^:(wdisparent'rona')''
  wd rona_form
else. 'wants to be run from jqt' end.
)

courir''