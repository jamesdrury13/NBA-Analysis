ui <- fluidPage(
    
    theme = shinytheme("cerulean"),
    
    tabsetPanel(
        
        tabPanel("NBA game day at a glance",
                 
                 fluidRow(
                     
                     column(
                         
                         dateInput(inputId = "date",
                                   label = "Date",
                                   value = "2021-10-20",
                                   width = 120),
                         
                         width = 3), # column end
                     
                 ), # fluidRow end
                 
                 fluidRow(
                     
                     column(
                         
                         width = 6,
                     
                         tableOutput("game_table") # tableOutput end
                         
                     ), # column end
                     
                     column(
                         
                         width = 6,
                         
                         plotOutput("shooting_graph")
                         
                     ), # column end
                     
                 ) # fluidRow end
                 
        ) # tabPanel end
        
    ) # tabsetPanel end
    
) # fluidPage end
                     
                 
                                 
                     
            
server <- function(input, output) {
    
    
    output$game_table <- renderTable({
        
        d %>%
            filter(dateGame == input$date) %>%
            distinct(slugMatchup, .keep_all = TRUE) %>%
            select(Team = nameTeam, Matchup = slugMatchup, Location = locationGame, Outcome = outcomeGame)
        
        
        
    }) # output$game_table end
    
    output$shooting_graph <- renderPlot({
        
        team_shooting_barplot(input$date, "Utah Jazz", 3)
        
    }) # output$shooting_graph end
    
    
    
    # output$player_table <- renderDataTable({
    #     player_career(p = input$player_name,
    #                   season_type = input$season_type)
    # })
    # 
    # output$season_table <- renderDataTable({
    #     season(season = input$season)
    # })
    
}





# # Define UI for application that draws a histogram
# ui <- fluidPage(
# 
#     # Application title
#     titlePanel("Old Faithful Geyser Data"),
# 
#     # Sidebar with a slider input for number of bins 
#     sidebarLayout(
#         sidebarPanel(
#             sliderInput("bins",
#                         "Number of bins:",
#                         min = 1,
#                         max = 50,
#                         value = 30)
#         ),
# 
#         # Show a plot of the generated distribution
#         mainPanel(
#            plotOutput("distPlot")
#         )
#     )
# )
# 
# # Define server logic required to draw a histogram
# server <- function(input, output) {
# 
#     output$distPlot <- renderPlot({
#         # generate bins based on input$bins from ui.R
#         x    <- faithful[, 2]
#         bins <- seq(min(x), max(x), length.out = input$bins + 1)
# 
#         # draw the histogram with the specified number of bins
#         hist(x, breaks = bins, col = 'darkgray', border = 'white')
#     })
# }




shinyApp(ui = ui, server = server)
