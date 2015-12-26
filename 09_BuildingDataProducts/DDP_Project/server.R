# Load shiny package
library(shiny)

# Load analysis file
source("analysis.R")

# Shiny server
shinyServer(
        function(input, output) {
                # Initialize reactive values
                values <- reactiveValues()
                values$leagues <- leagues

                # Create event type checkbox
                output$leaguesControl <- renderUI({
                        checkboxGroupInput('leagues', 'SCII Leagues:',
                                           leagues, selected = values$leagues)
                })

                # Add observer on select-all button
                observe({
                        if(input$selectAll == 0) return()
                        values$leagues <- leagues
                })

                # Add observer on clear-all button
                observe({
                        if(input$clearAll == 0) return()
                        values$leagues <- c() # empty list
                })


                # Prepare dataset
                dataTable <- reactive({
                        groupByLeague(mydata, input$playerage[1],
                                     input$playerage[2], input$playerapm[1],
                                     input$playerapm[2], input$leagues)
                })

                dataTableByAgeAll <- reactive({
                        groupByAgeAll(mydata, input$playerage[1],
                                       input$playerage[2], input$playerapm[1],
                                       input$playerapm[2], input$leagues)
                })
                
                dataTableByAPMAgeAvg <- reactive({
                        groupByAPMAgeAvg(mydata, input$playerage[1], 
                                        input$playerage[2], input$playerapm[1],
                                        input$playerapm[2], input$leagues)
                })

                dataTableByAPMLeagueAvg <- reactive({
                        groupByAPMLeagueAvg(mydata, input$playerage[1],
                                             input$playerage[2], input$playerapm[1],
                                             input$playerapm[2], input$leagues)
                })

                # Render data table
                output$dTable <- renderDataTable({
                        dataTable()
                })
                
                output$apmByAgeAvg <- renderChart({
                        plotAPMByAgeAvg(dataTableByAPMAgeAvg())
                })

                output$apmByLeagueAvg <- renderChart({
                        plotAPMByLeagueAvg(dataTableByAPMLeagueAvg())
                })

        } # end of function(input, output)
)
