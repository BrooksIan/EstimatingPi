install.packages('shiny') 

library('shiny')

runApp(port=as.numeric(Sys.getenv("CDSW_READONLY_PORT")), host="127.0.0.1", launch.browser="FALSE")
