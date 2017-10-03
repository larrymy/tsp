shinyUI( 
      fluidPage(      
            sidebarLayout(
                  sidebarPanel(
                  actionButton("add", "Add 'Dynamic' tab"),
                  
                  width = 2
            ),
            mainPanel(  
                  tabsetPanel(id = "tabs",
                    tabPanel("Hello", #tab panel hello
                    
                  
                  htmlOutput("inc"),
                  h3("Shiny Chart - A KLSE Charting App"),
                  h4("Version 2.2"),
                  h4("Created by Jun Yitt"),
                  column(12, p("It is recommended to use the Adjust Date slider instead of the default slider of Plotly to have the y-axis auto-scale functionality. The dropdown menu is also a search box. Select, then <Backspace>, then key in the stock name/code you desire.")),
                  # column(4,
                  # selectInput(
                  #       "reference_name2", label = strong("Ticker/Stock"), choices = my_autocomplete_list, selectize = T, selected = ""
                  # )),
                  br(),
                  useShinyjs(),
                  div(
                        id = "loading_page",
                        h3("Loading Data... Please wait :)")
                  ),
                  fluidRow(
                  column(4, uiOutput("tickerbox") ),
                  column(5, uiOutput("slider33") ),
                  column(3, uiOutput("tickerhyperlink"))
                  ),
                  
                  br(),
                  br(),
  
                  column(8, plotlyOutput("distPlot", width = "100%") ),
                  
                  br()
                  ), #end of tab panel hello
                  tabPanel("Foo", "This is the foo tab"),
                    tabPanel("Bar", "This is the bar tab"),
                  br()
                  
                  ) #end of tab panel
            )#end of main panel

)
      )
)
