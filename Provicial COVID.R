install.packages("tidyverse")
library(tidyverse)
install.packages("gganimate")
library(gganimate)
install.packages("gifski")
library(gifski)

prov = read.csv(file = "/cloud/project/Provicial COVID.csv")
prov = prov %>% slice(-1) %>% mutate(BC = coalesce(BC, 0), AB = coalesce(AB, 0), SK = coalesce(SK, 0), MB = coalesce(MB, 0), ON = coalesce(ON, 0), QC = coalesce(QC, 0), NB = coalesce(NB, 0), PE = coalesce(PE, 0), NS = coalesce(NS, 0), NL = coalesce(NL,0), YT = coalesce(YT, 0), NT = coalesce(NT, 0), NU = coalesce(NU,0))
prov2 = prov %>% pivot_longer(BC:NU, names_to = "Province", values_to = "CaseInc")
prov_names = c('BC','AB','SK','MB','ON','QC','NB','PE','NS','NL','YT','NT','NU' )
gov_type = c('Minority', 'Majority', 'Majority', 'Majority', 'Majority', 'Majority', 'Minority', 'Minority', 'Majority', 'Minority', 'Majority', 'Nonpartisan', 'Nonpartisan')
party_pos = c('Centre-left','Centre-right','Centre-right','Centre-right','Centre-right','Centre-right','Centre-right','Centre-right','Centre-right','Centre-left','Centre-left','Nonpartisan','Nonpartisan')
prov2 = prov2 %>% mutate(GovType = "") %>% mutate(PartyPosition = "") %>% mutate(Day = 0)
prov2$GovType <- gov_type[match(prov2$Province, prov_names)]
prov2$PartyPosition <- party_pos[match(prov2$Province, prov_names)]
prov = read.csv(file = "/cloud/project/Provicial COVID Clean.csv")
prov=prov %>% mutate(Day = 0) 
x=1
for(i in 1:length(prov$Date)){
  prov$Day[i] = x
  if(i %% 13 == 0){
    x=x+1
  }
}

write.csv(prov,"/cloud/project/Provicial COVID Clean.csv", row.names = FALSE)
