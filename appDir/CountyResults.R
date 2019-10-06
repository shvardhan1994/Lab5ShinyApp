

CountyResults <- function(County_name){
  url <- "https://data.val.se/val/val2014/statistik/2014_riksdagsval_per_kommun.xls"
  httr::GET(url = url, httr::write_disk(tf <- tempfile(fileext = ".xls")))
  get_data_temp <- readxl::read_excel(tf, 1L, col_names = TRUE)
  get_data <- get_data_temp[-1,]
  colnames(get_data) <- c(get_data[1,])
  get_data <- get_data[-1,]
  get_data_df <- as.data.frame(get_data)
  get_data_df$LAN <- NULL
  get_data_df$KOM <- NULL
  colnames(get_data_df) <- c("County","Municipality","M","MPER","C","CPER","FP","FPPER","KD","KDPER","S","SPER","V","VPER","MP","MPPER","SD","SDPER","FI","FPPER","OVR","OVRPER","BL","BLPER","OGPER","OG")
  #names(get_data_df)[names(get_data_df) == "KOMMUN"] <- "Municipality"
  #names(get_data_df)[names(get_data_df) == "LÄN"] <- "County"
  
  if( is.character(County_name) & County_name %in% get_data_df$County){
    
    county_df_temp <- get_data_df[get_data_df$County == County_name,]
    county_df <- county_df_temp[-c(1,2,4,6,8,10,12,14,16,18,20,22,24,26,27,28,29,30,31)]
    #colnames(county_df) <- c("M","C","FP","KD","S","V","MP","SD","FI","OVR","BL","OG")
    all_num_df <- as.data.frame(sapply(county_df,as.numeric))
    y_axis_c <- apply(all_num_df[,1:12],2,sum)
    
    x_axis_c <- c("M","C","FP","KD","S","V","MP","SD","FI","OVR","BL","OG")
    partynames <- c("M = Moderates","C = The Center Party","FP = The Liberal Party","KD = The Christian Democrats",
                    "S = Labor-Socialdemokraterna","V = The Left","MP = The environmental party the Greens","SD = Sweden Democrats",
                    "FI = Feminist Initiative","OVR = Other parties","BL = Invalid voices - blank","OG = Invalid votes - others")
    PartyNames <- vector()
    TotalVotes <- vector()
    fun2_df <- data.frame(PartyNames = x_axis_c, TotalVotes = y_axis_c)
    p2<-ggplot2::ggplot(data=fun2_df, ggplot2::aes(x=PartyNames, y=TotalVotes, fill=partynames)) +
      ggplot2::geom_bar(stat="identity") + 
      ggplot2::geom_text(aes(label=TotalVotes), vjust=1.6, color="black", size=3.5) + 
      ggplot2::theme_minimal() + ggplot2::labs(title = "County Result")
    return(p2)
  } else stop("Input arguments are not character type : Check your Input")
}

#CountyResults(County_name = "Dalarnas län")



