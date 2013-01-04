hl = Game.create(:name => "Half-Life")
hl2 = Game.create(:name => "Half-Life 2")
#hl2_e1 = Game.create(:name => "Half-Life 2: Episode One")
hl2_e2 = Game.create(:name => "Half-Life 2: Episode Two")
hl2_e3 = Game.create(:name => "Half-Life 2: Episode Three")
tf2 = Game.create(:name => "Team Fortress 2")

time_frames = [
  {:name => "Half-Life release", :expect_day => 1, :expect_month => 11, :expect_year => 1997,
   :advance_by_day => 18, :advance_by_month => 1, :advance_by_year => 1, :games => [hl]},
  {:name => "First mention of Team Fortress 2", :expect_year => 1998,
   :advance_by_day => 10, :advance_by_month => 10, :advance_by_year => 9, :games => [tf2]},
  {:name => "Developers interview about Team Fortress 2", :expect_year => 1998,
   :advance_by_day => 10, :advance_by_month => 10, :advance_by_year => 9,
   :source => "Gamespot", :source_url => "http://www.gamespot.com/pc/action/teamfortress2boa/news.html?sid=2652476&mode=previews&tag=stitialclk;gamespace", :games => [tf2]},
  {:name => "Developers interview about Half-Life 2", :expect_month => 9, :expect_year => 2003,
   :advance_by_day => 16, :advance_by_month => 2, :advance_by_year => 1,
   :source => "GameSpy", :source_url => "http://archive.gamespy.com/e32003/preview/pc/1002433/", :games => [hl2]},
  {:name => "Developers interview about Half-Life 2: Episode Two", :expect_day => 1, :expect_month => 6, :expect_year => 2006,
   :advance_by_day => 9, :advance_by_month => 4, :advance_by_year => 1,
   :source => "GameSpot", :source_url => "http://www.gamespot.com/pc/action/halflife2episode2ob/news.html?sid=6151796", :games => [hl2_e2]},
  {:name => "The latest known date about Half-Life 2: Episode Three", :expect_month => 12, :expect_year => 2007,
   :actual_release => "Coincident with the Rapture",# :explanation => "",
   :source => "GameSpot", :source_url => "http://www.gamespot.com/pc/action/halflife2episode2ob/news.html?sid=6151796", :games => [hl2_e3]},
  {:explanation => "Availability of the Earbuds in Team Fortress 2", :expect_in_days => 4,
   :advance_by_day => 6, :advance_by_month => 2,
   :source => "Team Fortress 2 Mac Update", :source_url => "http://www.teamfortress.com/macupdate/earbuds/"},

  {:name => "In the coming weeks...", :explanation => "Team Fortress 2 Achievements addition for each class, that came in large updates starting in five months and continuingover the next two and a half years",
   :expect_in_days => 14, :advance_by_year => 2, :advance_by_month => 6,
   :source => "Steam Updates", :source_url => "http://storefront.steampowered.com/Steam/Marketing/message/1346/"},
  {:explanation => "This particular Team Fortress 2 Update was postponed for 3 hours", :expect_hours => 11, :advance_by_hours => 3,
   :source => "Steam updates", :source_url => "http://store.steampowered.com/news/1440/"},
  {:explanation => "Team Fortress 2 Beta went live at the same time at almost midnight of Pacific time, despite being announced for the brginning of the day", :expect_in_days => 0,
   :advance_by_hours => 23, :advance_by_minutes => 49},
  {:explanation => "Steam Community went live a month after the stated release date", :expect_day => 1, :advance_by_month => 1,
   :source => "Valve Developer Wiki", :source_url => "http://developer.valvesoftware.com/wiki/The_Steam_Community"},

  # Goldrush update
  {:explanation => "Team Fortress 2 Gold Rush Update was delayed three times since February 1st until it was finally released at end of April",
   :expect_month => 2, :advance_by_month => 2, :advance_by_day => 29,
   :source => "Steam Updates", :source_url => "http://storefront.steampowered.com/Steam/Marketing/message/1426/"},
  {:explanation => "Team Fortress 2 Gold Rush Update was delayed three times since February 1st (second time at April 15th) until it was finally released at end of April",
   :expect_day => 15, :expect_month => 4, :advance_by_day => 14,
   :source => "Computer and Video Games Online", :source_url => "http://www.computerandvideogames.com/article.php?id=185631&site=cvg"}
]
20.upto(26) do |day|
  time_frames << {:explanation => "Team Fortress 2 Gold Rush Update was delayed three times since February 1st - third time stating it will be released on \"the week of April 20th\", finally being released at the very end of April",
     :expect_month => 4, :expect_day => day, :advance_by_day => 29-day,
     :source => "ShackNews", :source_url => "http://www.shacknews.com/onearticle.x/51941"}
end
time_frames = time_frames + [
  {:explanation => "Day of Defeat Source Steamworks beta went live three months after the first given release date.",
   :expect_month => 1, :advance_by_month => 4, :advance_by_day => 22,
   :source => "Steam Forums", :source_url => "http://forums.steampowered.com/forums/showpost.php?p=7097740&postcount=149"},
  {:explanation => "Day of Defeat Source Steamworks beta went live two months after the second given release date.",
   :expect_month => 3, :advance_by_month => 1, :advance_by_day => 22,
   :source => "Enemy Down", :source_url => "http://www.enemydown.co.uk/forumreplies.php?id=117371"},
  {:explanation => "The release of Alien Swarm",
   :expect_in_hours => 1, :advance_by_hours => 2, :advance_by_minutes => 15},
  {:explanation => "On the 119th Update it was said, the Engineer class update for Team Fortress 2 will come \"Soon\". The update was released two months later.",
   :expect_month => 4, :expect_day => 18, :advance_by_day => 8, :advance_by_month => 2,
   :source => "Team Fortress 2 119th Update", :source_url => "http://www.teamfortress.com/119/comingsoon.html"}
]
time_frames.each do |time_frame|
  TimeFrame.create(time_frame)
end
