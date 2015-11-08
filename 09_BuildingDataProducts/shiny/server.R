shinyServer(
        function(input, output) {
                output$text1 <- renderText({input$text1})
                output$text2 <- renderText({input$text2})
                output$text3 <- renderText({
                        # First Example. Uncomment to take effect.
                        #input$goButton
                        #isolate(paste(input$text1, input$text2))
                        
                        # Second Example. Uncomment to take effect.
                        if (input$goButton == 0) "You have not pressed the button"
                        else if (input$goButton == 1) "you pressed it once"
                        else "OK quit pressing it"
                })
        }
)