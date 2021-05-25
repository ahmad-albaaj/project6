library(shiny)
library(plotly)


shinyServer(function(input, output) {
    y <- list(title = "Weight")
    x <- list(
        categoryorder = "array",
        categoryarray = sort(rownames(mtcars), T),
        tickangle = -45,
        title = "Name"
    )
    l <- list(
        x = 0.4,
        y = -0.75, 
        orientation = "h", 
        font = list( 
            family = "sans-serif",
            size = 12,
            color = "#000"),
        bgcolor = "#F5F5F5",
        bordercolor = "#000",
        borderwidth = 2
    )
    
    
    output$barchart <- renderPlotly({
        #Transmission (0 = automatic, 1 = manual)
        dat <- mtcars %>% mutate(am = ifelse(am == 0, "automatic", "manual"))
        #rownames are not automatically transferred
        rownames(dat) <- rownames(mtcars)
        
        plot_ly(
            data = dat,
            y = ~wt,
            x = rownames(dat),
            color = ~am,
            type = "bar", text = ~cyl,
            hovertemplate = paste0("<b>Name</b>: %{x}<br>",
                                   "<i>Weight</i>: %{y:.2f} (1000 lbs)<br>",
                                   "Cylinders: %{text}" ,
                                   "<extra></extra>"
            )
        ) %>% layout(title="Cars", xaxis = x, yaxis = y,legend = l)
    })
    
})
