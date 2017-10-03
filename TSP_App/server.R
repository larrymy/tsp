#############
# SERVER
###############
shinyServer(function(input, output, session) {

     
      
      
      output$tickerbox <- shiny::renderUI({
            selectInput(
                        "reference_name", label = strong("Ticker/Stock"), choices = my_autocomplete_list, selectize = T, selected = ""
                  )
      }) 
      
      
      
      nr <- shiny::reactive({
            ticker_raw <- input$reference_name
            pos1 <- gregexpr(pattern = "[(]", ticker_raw)[[1]][1]
            pos2 <- gregexpr(pattern = "[)]", ticker_raw)[[1]][1]
            ticker <<- substr(x = ticker_raw, start = pos1+1, stop = pos2-1); ticker <- trimws(ticker)

            u1 <- plot_df[,"code"] == ticker
          
            plot_df2 <- plot_df[u1,]
            return( nrow(plot_df2) )
      })
      
      output$slider33 <- shiny::renderUI({
            shiny::sliderInput("slider22", label = strong("Adjust Date"),
                    min = 1, max = nr(), value = c(1, nr()))
      })
      
        
      pp <- shiny::reactive({
            ticker_raw <- input$reference_name
            pos1 <- gregexpr(pattern = "[(]", ticker_raw)[[1]][1]
            pos2 <- gregexpr(pattern = "[)]", ticker_raw)[[1]][1]
            ticker <<- substr(x = ticker_raw, start = pos1+1, stop = pos2-1); ticker <- trimws(ticker)

            kk <- ceiling(input$slider22[1]):ceiling(input$slider22[2])
            
            u1 <- plot_df[,"code"] == ticker
            
            plot_df2 <- plot_df[u1,]
            plot_df2 <- plot_df2[kk,]


            p_obj <- tfunction::plotly_price_f(plot_df2, ticker)
            
            return(p_obj)
      })
        
      #output hyperlink
      urlticker <- shiny::reactive({
            ticker_raw <- input$reference_name
            pos1 <- gregexpr(pattern = "[(]", ticker_raw)[[1]][1]
            pos2 <- gregexpr(pattern = "[)]", ticker_raw)[[1]][1]
            ticker <<- substr(x = ticker_raw, start = pos1+1, stop = pos2-1); ticker <- trimws(ticker)
            
            x <- paste0("http://www.malaysiastock.biz/Corporate-Infomation.aspx?securityCode=", ticker);
            xx <- a("Fundamental Information", href=x)
            
            return(xx);
      })
        
            

      output$distPlot <- renderPlotly({
                      
            pp()
      })
      
      #Side bar
      
      output$tickerhyperlink <- renderUI({
            tagList("", urlticker())
      })
      
     
      session$onSessionEnded(function() {
            shiny::stopApp()
      })
})
