# The user-interface setup for the Shiny web app
library(shiny)
library(BH)
library(rCharts)
require(markdown)
require(data.table)
library(dplyr)
library(DT)

shinyUI(
        navbarPage("SkillCraft1 Visualizer of Starcraft II Replays",
                   # multi-page user-interface that includes a navigation bar.
                   tabPanel("Explore the Data",
                            sidebarPanel(
                                    sliderInput("playerapm",
                                                "APM (Actions per Minute):",
                                                min = 22.1,
                                                max = 389.8314,
                                                value = c(22.1, 389.8314)
                                    ),
                                    sliderInput("playerage",
                                                "Player Age:",
                                                min = 16,
                                                max = 44,
                                                value = c(16, 44)),

                                    uiOutput("leaguesControl"), # the id

                                    actionButton(inputId = "clearAll",
                                                 label = "Clear selection",
                                                 icon = icon("square-o")),
                                    actionButton(inputId = "selectAll",
                                                 label = "Select all",
                                                 icon = icon("check-square-o"))

                            ),
                            mainPanel(
                                    tabsetPanel(
                                            # 'Dataset' tab panel
                                            tabPanel(p(icon("table"), "Dataset"),
                                                     dataTableOutput(outputId="dTable")
                                            ),
                                            # 'Visualize the Data' tab panel
                                            tabPanel(p(icon("line-chart"), "Visualize the Data"),
                                                     h4('Average APM by Age', align = "center"),
                                                     showOutput("apmByAgeAvg", "nvd3"),
                                                     h4('Average APM by League', align = "center"),
                                                     showOutput("apmByLeagueAvg", "nvd3")
                                            )

                                    )

                            )
                   ), # end of "Explore Dataset" tab panel

                   tabPanel("About",
                        mainPanel(
                        includeMarkdown("about.md")
                        )
                   ) # end of "About" tab panel
        )

)
