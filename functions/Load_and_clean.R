library(googledrive)
library(googlesheets4)
library(tidyverse)
library(stringr)
library(lubridate)
library(magrittr)

options(gargle_oauth_email="philip.leftwich@gmail.com")
dd <- drive_get("Copy_of_UCU_member_survey") %>%
  read_sheet()



ddyYqs <- colnames(dd)

# make sure all school name abbreviations are uniform by mutating column 2 into a new vector
dd %<>% mutate(school = str_to_upper(.[[2]])) ### pipe and update


mybar <- function(data, n, ordered = FALSE,colbyrisk = TRUE, perc=TRUE)
{
  data$cq <- pull(data,n)

  myangle <- ifelse(is.numeric(data$cq),0,0)
  myvjust <- ifelse(is.numeric(data$cq),0,0.5)
  myhjust <- ifelse(is.numeric(data$cq),0.95,0.5)
  myxlab <- ifelse(is.numeric(data$cq),"Not at all satisfied >>> Very satisfied","")
  data %<>%
    filter(!(is.na(cq))) %>%
    mutate(cq = str_wrap(cq,width = 20))
  
  if(ordered){data$cq <- factor(data$cq,levels = names(table(data$cq)[order(table(data$cq),decreasing = T)]))}
  
  if(!colbyrisk)
  {
    if(perc) {     
      ggplot(data, aes(x = cq)) +  
        geom_bar(fill = "hotpink1") + 
        geom_text(aes(label=sprintf("%1.2f%%", stat(prop)*100), group=1),stat='count', vjust=-0.5, size=3)+
        theme(axis.text.x = element_text(angle = myangle,
                                         hjust=myhjust,vjust=myvjust))+
        ylab("Count")+
        xlab(myxlab)
    } else {            
    ggplot(data, aes(x = cq)) +  
      geom_bar(fill = "hotpink1") + 
      theme(axis.text.x = element_text(angle = myangle,
                                       hjust=myhjust,vjust=myvjust))+
      ylab("Count")+
      xlab(myxlab)
  }
    }else
  {
    data$myfill <- ifelse(grepl("low risk",pull(data, 3)),"Low risk", "High risk")
    data$myfill <- factor(data$myfill,levels = c("Low risk","High risk"))
    ggplot(data, aes(x = cq,fill = myfill)) +
      geom_bar(position = "stack")+
      geom_text(aes(label=sprintf("%1.2f%%", stat(prop)*100), group=1),stat='count', vjust=-0.5, size=3)+
      theme(axis.text.x = element_text(angle = myangle,
                                       hjust=myhjust,vjust=myvjust),
            legend.title = element_blank()) +
      ylab("Count")+
      xlab(myxlab)+
      scale_fill_manual(values = c("purple4","hotpink1"))
  }

}


