const visObject = {
    // Id and Label are legacy properties that no longer have any function besides documenting
    // what the visualization used to have. The properties are now set via the manifest
    // form within the admin/visualizations page of Looker
    id: "bar_chart_race",
    label: "Bar Chart Race",
    options: {
        raceDuration: {
            default: 5,
            label: 'Race Duration',
            order: 1,
            section: 'Race Settings',
            type: 'number',
            display: 'range',
            min: 1,
            max: 10,
        },
        barsShown: {
            default: 12,
            label: 'Number of Bars Displayed',
            order: 1,
            section: 'Chart Settings',
            type: 'number',
        },
        colourByCategory: {
            default: true,
            label: 'Enable Colour By Category',
            order: 2,
            section: 'Chart Settings',
            type: 'boolean',
        },
        showCategoryLegend: {
            default: false,
            label: 'Enable Colour By Category Legend',
            order: 3,
            section: 'Chart Settings',
            type: 'boolean',
        },
        defaultBarColour: {
            display: 'color',
            display_size: 'third',
            label: 'Default Bar Colour',
            order: 4,
            section: 'Chart Settings',
            type: 'string',
            default: '#00A699',
        },
        categoryColourPalette: {
            display: 'colors',
            display_size: 'third',
            label: 'Category Colour Palette',
            order: 4,
            section: 'Chart Settings',
            type: 'array',
        }

    },


// Set up the initial state of the visualization
    create: function(element) {
        element.innerHTML = "<h1>Ready to render!</h1>";

    },
    // Render in response to the data or settings changing
    updateAsync: function(data, element, config, queryResponse, details, doneRendering) {

        // Clear any errors from previous updates
        this.clearErrors();

        if (config.colourByCategory === true) {
        // Throw some errors and exit if the shape of the data isn't what this chart needs
            if (queryResponse.fields.dimensions.length != 3) {
                this.addError({
                    title: "Not correct number of dimensions",
                    message: "This chart requires 3 dimensions. Refer to confluence for guidance"
                });
                return;
            }
        }
        else {
            if (queryResponse.fields.dimensions.length < 2) {
                this.addError({
                    title: "Not correct number of dimensions",
                    message: "This chart requires 2 dimensions. Refer to confluence for guidance"
                });
                return;
            }
        }
        if (queryResponse.fields.measures.length != 1) {
            this.addError({
                title: "Not correct number of measures",
                message: "This chart requires 1 measure. Refer to confluence for guidance"
            });
            return;
        }

        // Insert a <style> tag with some styles we'll use later.
        element.innerHTML = `
              <style>
                #bar-chart-race {
                  position: absolute;
                  left: 0px;
                  width: 100%;
                }
                text{
                  font-size: 16px;
                  font-family: Open Sans, sans-serif;
                }
                  text.label{
                    font-weight: 600;
                  }
                
                  text.valueLabel{
                   font-weight: 300;
                  }
                
                  text.dateText{
                    font-size: 40px;
                    font-weight: 700;
                    opacity: 0.25;
                  }
                  .tick text {
                    fill: #777777;
                  }
                  .xAxis .tick:nth-child(2) text {
                    text-anchor: start;
                  }
                  .tick line {
                    shape-rendering: CrispEdges;
                    stroke: #dddddd;
                  }
                  .tick line.origin{
                    stroke: #aaaaaa;
                  }
                  path.domain{
                    display: none;
                  }
                  #legend svg {
                    height: 300px; 
                  }
              </style>

            <body>
              <div class="bar-chart-race">
                <ct-visualization id="bar-chart-race"></ct-visualization>
                <script>
                </script>
              </div>
            </body>
        `;

      function make_race(data, distinct_dates, min_date, colours, measure_name, measure_format) {

        var svg = d3.select("#bar-chart-race").append("svg")
          .attr("width", 960)
          .attr("height", 500);
        
        var tickDuration = 900 - (config.raceDuration * 50);
        
        var top_n = config.barsShown;
        var height = 500;
        var width = 960;
        
        const margin = {
          top: 50,
          right: 0,
          bottom: 5,
          left: 0
        };

        var text_label_prefix = ""
        if (measure_format.includes("$")) {
            text_label_prefix = "$"
        }
        else if (measure_format.includes("£")) {
            text_label_prefix = "£"
        };
      
        let barPadding = (height-(margin.bottom+margin.top))/(top_n*5);
          
          if (config.colourByCategory === true) {
               data.forEach(d => {
                d.value = +d.running_total,
                d.lastValue = +d.previous_value,
                d.category = d.category,
                d.value = isNaN(d.running_total) ? 0 : d.running_total,
                d.colour = d.colour.colour
              });
           }
           else {
            data.forEach(d => {
                d.value = +d.running_total,
                d.lastValue = +d.previous_value,
                d.value = isNaN(d.running_total) ? 0 : d.running_total,
                d.colour = config.defaultBarColour
              });
           }

         let dateSlice = data.filter(d => d.date == min_date && !isNaN(d.value))
          .sort((a,b) => b.value - a.value)
          .slice(0, top_n);
      
          dateSlice.forEach((d,i) => d.rank = i);
      
         let x = d3.scaleLinear()
            .domain([0, d3.max(dateSlice, d => d.value)])
            .range([margin.left, width-margin.right-65]);
      
         let y = d3.scaleLinear()
            .domain([top_n, 0])
            .range([height-margin.bottom, margin.top]);
      
         let xAxis = d3.axisTop()
            .scale(x)
            .ticks(width > 500 ? 5:2)
            .tickSize(-(height-margin.top-margin.bottom))
            .tickFormat(d => d3.format(',')(d));
      
         svg.append('g')
           .attr('class', 'axis xAxis')
           .attr('transform', `translate(0, ${margin.top})`)
           .call(xAxis)
           .selectAll('.tick line')
           .classed('origin', d => d == 0);
      
         svg.selectAll('rect.bar')
            .data(dateSlice, d => d.name)
            .enter()
            .append('rect')
            .attr('class', 'bar')
            .attr('x', x(0)+1)
            .attr('width', d => x(d.value)-x(0)-1)
            .attr('y', d => y(d.rank)+5)
            .attr('height', y(1)-y(0)-barPadding)
            .style('fill', d => d.colour);
          
         svg.selectAll('text.label')
            .data(dateSlice, d => d.name)
            .enter()
            .append('text')
            .attr('class', 'label')
            .attr('x', d => x(d.value)-8)
            .attr('y', d => y(d.rank)+5+((y(1)-y(0))/2)+1)
            .style('text-anchor', 'end')
            .html(d => d.name);
          
        svg.selectAll('text.valueLabel')
          .data(dateSlice, d => d.name)
          .enter()
          .append('text')
          .attr('class', 'valueLabel')
          .attr('x', d => x(d.value)+5)
          .attr('y', d => y(d.rank)+5+((y(1)-y(0))/2)+1)
          .text(d => text_label_prefix + d3.format(',.0f')(d.lastValue));

        svg.append("text")
           .attr("transform", "translate(100,0)")
           .attr("x", 550)
           .attr("y", 20)
           .attr("font-size", "24px")
           .attr("fill", "#aaaaaa")
           .text(measure_name)

        let dateText = svg.append('text')
          .attr('class', 'dateText')
          .attr('x', width-margin.right)
          .attr('y', height-25)
          .style('text-anchor', 'end')
          .html(date)
          .call(halo, 10);


        if (config.colourByCategory === true && config.showCategoryLegend === true) {
            var legendRectSize = 18;
            var legendSpacing = 4;  

            var legend = svg.selectAll('.legend')
              .data(colours)
              .enter()
              .append('g')
              .attr('class', 'legend')
              .attr('transform', function(d, i) {
                var height = legendRectSize + legendSpacing;
                var offset =  height * colours.length / 2;
                var vert = (i * height - offset) + 300;
                return 'translate(' + 800 + ',' + vert + ')';
              });

            legend.append('rect')                                 
              .attr('width', legendRectSize)                      
              .attr('height', legendRectSize)                     
              .style('fill', function(d) { return d.colour; })                               
              .style('stroke', function(d) { return d.colour; });                            
                
            legend.append('text')                                 
              .attr('x', legendRectSize + legendSpacing)          
              .attr('y', legendRectSize - legendSpacing)          
              .text(function(d) { return d.category; }); 
        };

        let ticker = d3.interval(e => {

          dateSlice = data.filter(d => d.date == min_date && !isNaN(d.value))
            .sort((a,b) => b.value - a.value)
            .slice(0,top_n);
          dateSlice.forEach((d,i) => d.rank = i);

          x.domain([0, d3.max(dateSlice, d => d.value)]); 
         
          svg.select('.xAxis')
            .transition()
            .duration(tickDuration)
            .ease(d3.easeLinear)
            .call(xAxis);
        
           let bars = svg.selectAll('.bar').data(dateSlice, d => d.name);
        
           bars
            .enter()
            .append('rect')
            .attr('class', d => `bar ${d.name.replace(/\s/g,'_')}`)
            .attr('x', x(0)+1)
            .attr( 'width', d => x(d.value)-x(0)-1)
            .attr('y', d => y(top_n+1)+5)
            .attr('height', y(1)-y(0)-barPadding)
            .style('fill', d => d.colour)
            .transition()
              .duration(tickDuration)
              .ease(d3.easeLinear)
              .attr('y', d => y(d.rank)+5);
              
           bars
            .transition()
              .duration(tickDuration)
              .ease(d3.easeLinear)
              .attr('width', d => x(d.value)-x(0)-1)
              .attr('y', d => y(d.rank)+5);
                
           bars
            .exit()
            .transition()
              .duration(tickDuration)
              .ease(d3.easeLinear)
              .attr('width', d => x(d.value)-x(0)-1)
              .attr('y', d => y(top_n+1)+5)
              .remove();

           let labels = svg.selectAll('.label')
              .data(dateSlice, d => d.name);
         
           labels
            .enter()
            .append('text')
            .attr('class', 'label')
            .attr('x', d => x(d.value)-8)
            .attr('y', d => y(top_n+1)+5+((y(1)-y(0))/2))
            .style('text-anchor', 'end')
            .html(d => d.name)    
            .transition()
              .duration(tickDuration)
              .ease(d3.easeLinear)
              .attr('y', d => y(d.rank)+5+((y(1)-y(0))/2)+1);
                 
        
           labels
              .transition()
              .duration(tickDuration)
                .ease(d3.easeLinear)
                .attr('x', d => x(d.value)-8)
                .attr('y', d => y(d.rank)+5+((y(1)-y(0))/2)+1);
         
           labels
              .exit()
              .transition()
                .duration(tickDuration)
                .ease(d3.easeLinear)
                .attr('x', d => x(d.value)-8)
                .attr('y', d => y(top_n+1)+5)
                .remove();
             
           let valueLabels = svg.selectAll('.valueLabel').data(dateSlice, d => d.name);
        
           valueLabels
              .enter()
              .append('text')
              .attr('class', 'valueLabel')
              .attr('x', d => x(d.value)+5)
              .attr('y', d => y(top_n+1)+5)
              .text(d => d3.format(',.0f')(d.lastValue))
              .transition()
                .duration(tickDuration)
                .ease(d3.easeLinear)
                .attr('y', d => y(d.rank)+5+((y(1)-y(0))/2)+1);
                
           valueLabels
              .transition()
                .duration(tickDuration)
                .ease(d3.easeLinear)
                .attr('x', d => x(d.value)+5)
                .attr('y', d => y(d.rank)+5+((y(1)-y(0))/2)+1)
                .tween("text", function(d) {
                   let i = d3.interpolateRound(d.lastValue, d.value);
                   return function(t) {
                     this.textContent = text_label_prefix + d3.format(',')(i(t));
                  };
                });
          
         
          valueLabels
            .exit()
            .transition()
              .duration(tickDuration)
              .ease(d3.easeLinear)
              .attr('x', d => x(d.value)+5)
              .attr('y', d => y(top_n+1)+5)
              .remove();
        
          dateText.html(min_date);


         date_index = distinct_dates.indexOf(min_date);
         if(date_index == distinct_dates.length - 1) ticker.stop();
         if(date_index >= 0 && date_index < distinct_dates.length)
         date = new Date(distinct_dates[date_index + 1]);
         var milliseconds = new Date(date);
         var years = milliseconds.getFullYear();
         var months = ('0' + (milliseconds.getMonth()+1)).slice(-2)
         var days = ('0' + milliseconds.getDate()).slice(-2);

         min_date = years + '-' + months + '-' + days;
       },tickDuration);

     };
        
     const halo = function(text, strokeWidth) {
      text.select(function() { return this.parentNode.insertBefore(this.cloneNode(true), this); })
        .style('fill', '#ffffff')
         .style( 'stroke','#ffffff')
         .style('stroke-width', strokeWidth)
         .style('stroke-linejoin', 'round')
         .style('opacity', 1);
       
    }  


    var item = {};
    var jsonObj = [];

    for (var row of data) {

        var name = row[queryResponse.fields.dimensions[0].name].value;
        var date = row[queryResponse.fields.dimensions[1].name].value;
        if (config.colourByCategory === true) {
            var category = row[queryResponse.fields.dimensions[2].name].value;
        } else {
            var category = ''
        }
        var raw_value = row[queryResponse.fields.measures[0].name].value;

        item = {};
        item.date = date;
        item.name = name;
        item.category = category;
        item.raw_value = raw_value;
        jsonObj.push(item);

    }

    var measure_name = queryResponse.fields.measures[0].label_short;
    var measure_format = queryResponse.fields.measures[0].value_format;

    jsonObj.sort(function(a, b) {
        return new Date(a.date) - new Date(b.date);
    });


    min_date = new Date(Math.min.apply(null, jsonObj.map(function(e) {
      return new Date(e.date);
    })));


    var min_years = min_date.getFullYear();
    var min_months = ('0' + (min_date.getMonth()+1)).slice(-2)
    var min_days = ('0' + min_date.getDate()).slice(-2);

    min_date = min_years + '-' + min_months + '-' + min_days;


    max_date = new Date(Math.max.apply(null, jsonObj.map(function(e) {
      return new Date(e.date);
    })));


    var max_years = max_date.getFullYear();
    var max_months = ('0' + (max_date.getMonth()+1)).slice(-2)
    var max_days = ('0' + max_date.getDate()).slice(-2);

    max_date = max_years + '-' + max_months + '-' + max_days;


    var distinct_dates = [...new Set(jsonObj.map(item => item.date))];

    if (config.colourByCategory === true) {
        var distinct_names = [];
        jsonObj.forEach(function(item){
          var i = distinct_names.findIndex(x => x.name == item.name);
          if(i <= -1){
            distinct_names.push({name: item.name, category: item.category});
          }
        });

        var distinct_categories = [...new Set(jsonObj.map(item => item.category))];
    }
    else {
        var distinct_names = [...new Set(jsonObj.map(item => item.name))];
    }


    if (config.colourByCategory === true) {
        var category_colours = [];
        var x=0
        distinct_categories.forEach(function (a) {
            item = {};
            item.category = a;
            item.colour = config.categoryColourPalette[x];
            x = x+1;
            category_colours.push(item);
        });
    };

    var all_names_dates = [];

    if (config.colourByCategory === true) {
        distinct_names.forEach(function (a) {
            var running_total = 0;
            distinct_dates.forEach(function (b) {
                item = {};
                item.date = b;
                item.name = a.name;
                item.category = a.category;
                item.previous_value = running_total;

                var value = 0;
                var find = jsonObj.filter(function(result) {
                   return result.date === b && result.name === a.name;
                 });

                if (find.length > 0) { 
                    value = find[0].raw_value
                };
                item.value = value;

                var colour = config.defaultBarColour;
                var colour_find = category_colours.filter(function(result) {
                   return result.category === a.category;
                 });

                if (colour_find.length > 0) { 
                    colour = colour_find[0]
                };

                item.colour = colour;
                running_total += value;
                item.running_total = running_total;
                all_names_dates.push(item);
            });
        });
    }
    else {
        distinct_names.forEach(function (a) {
            var running_total = 0;
            distinct_dates.forEach(function (b) {
                item = {};
                item.date = b;
                item.name = a;
                item.previous_value = running_total;

                var value = 0;
                var find = jsonObj.filter(function(result) {
                   return result.date === b && result.name === a;
                 });

                if (find.length > 0) { 
                    value = find[0].raw_value
                }
                item.value = value;
                running_total += value;
                item.running_total = running_total;
                all_names_dates.push(item);
            });
        });
    }

    make_race(all_names_dates, distinct_dates, min_date, category_colours, measure_name, measure_format);

    doneRendering();
    

    }
};

looker.plugins.visualizations.add(visObject);
