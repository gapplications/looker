looker.plugins.visualizations.add({
    // Id and Label are legacy properties that no longer have any function besides documenting
    // what the visualization used to have. The properties are now set via the manifest
    // form within the admin/visualizations page of Looker
    id: "metric_tree",
    label: "Metric Tree",
    options: {
        enableComparison: {
            default: false,
            label: 'Enable Period On Period Comparison',
            order: 1,
            section: 'Comparison',
            type: 'boolean',
        },
        missyElliott: {
            default: 'horizontal',
            display: 'select',
            label: 'Horizontal or Vertical Tree',
            order: 2,
            section: 'Formatting',
            type: 'string',
            values: [
              { 'Horizontal': 'horizontal' },
              { 'Vertical': 'vertical' },
            ],
        },
        positiveGrowthColor: {
            display: 'color',
            display_size: 'third',
            label: 'Positive Growth Colour',
            order: 7,
            section: 'Formatting',
            type: 'string',
            default: '#00A699'
        },
        negativeGrowthColor: {
            display: 'color',
            display_size: 'third',
            label: 'Negative Growth Colour',
            order: 8,
            section: 'Formatting',
            type: 'string',
            default: '#e50933'
        },
        noGrowthColor: {
            display: 'color',
            display_size: 'third',
            label: 'No Growth Colour',
            order: 9,
            section: 'Formatting',
            type: 'string',
            default: '#A3A3A3'
        },
        positiveGrowthTextColor: {
            display: 'color',
            display_size: 'third',
            label: 'Positive Growth Text Colour',
            order: 10,
            section: 'Formatting',
            type: 'string',
            default: '#ffffff'
        },
        negativeGrowthTextColor: {
            display: 'color',
            display_size: 'third',
            label: 'Negative Growth Text Colour',
            order: 11,
            section: 'Formatting',
            type: 'string',
            default: '#ffffff'
        },
        noGrowthTextColor: {
            display: 'color',
            display_size: 'third',
            label: 'No Growth Text Colour',
            order: 12,
            section: 'Formatting',
            type: 'string',
            default: '#ffffff'
        },
    },
    // Set up the initial state of the visualization
    create: function(element) {
        element.innerHTML = "<h1>Ready to render!</h1>";
    },
    // Render in response to the data or settings changing
    updateAsync: function(data, element, config, queryResponse, details, done) {

        // Clear any errors from previous updates
        this.clearErrors();

        // Throw some errors and exit if the shape of the data isn't what this chart needs
        if (queryResponse.fields.dimensions.length != 5) {
            this.addError({
                title: "Not correct number of dimensions",
                message: "This chart requires 5 dimensions. Refer to confluence for guidance"
            });
            return;
        }
        if (queryResponse.fields.measures.length != 6) {
            this.addError({
                title: "Not correct number of measures",
                message: "This chart requires 6 measures. Refer to confluence for guidance"
            });
            return;
        }
        
        element.innerHTML = `
        <style>
          #tree-container {
            position: absolute;
            left: 0px;
            width: 100%;
          }

          .svgContainer {
            display: block;
              margin: auto;
          }

          .node {
            cursor: pointer;
          }

          .node-rect {
          }

          .node-rect-closed {
            stroke-width: 2px;
            stroke: rgb(0,0,0);
          }

          .link {
            fill: none;
            stroke: lightsteelblue;
            stroke-width: 2px;
          }

          .arrow {
            fill: lightsteelblue;
            stroke-width: 1px;
          }

          .wordwrap {
            white-space: pre-wrap; /* CSS3 */
            white-space: -moz-pre-wrap; /* Firefox */
            white-space: -pre-wrap; /* Opera <7 */
            white-space: -o-pre-wrap; /* Opera 7 */
            word-wrap: break-word; /* IE */
          }

          .node-text {
            font: 7px sans-serif;
          }

          p {
            display: inline;
          }

          .textcolored {
            color: orange;
          }

          a.exchangeName {
            color: orange;
          }

          .toolTip {
              position: absolute;
              display: none;
              width: auto;
              height: auto;
              background: none repeat scroll 0 0 white;
              border: 0 none;
              border-radius: 8px 8px 8px 8px;
              box-shadow: -3px 3px 15px #888888;
              color: black;
              font: 14px sans-serif;
              padding: 5px;
              text-align: center;
          }

        </style>

        <body>
          <div class="tree-container">
              <ct-visualization id="tree-container"></ct-visualization>
              <script>
              </script>
          </div>
        </body>
      `;

        function treeBoxes(jsonData) {

            var margin = {
                    top: 0,
                    right: 0,
                    bottom: 100,
                    left: 0
                },
                // Height and width are redefined later in function of the size of the tree
                // (after that the data are loaded)
                width = 900 - margin.right - margin.left,
                height = 400 - margin.top - margin.bottom;

            var rectNode = {
                    width: 225,
                    height: 100,
                    textMargin: 5
                };
            var i = 0,
                duration = 750,
                root;

            var mousedown; // Use to save temporarily 'mousedown.zoom' value
            var mouseWheel,
                mouseWheelName,
                isKeydownZoom = false;

            var tree;
            var baseSvg,
                svgGroup,
                nodeGroup,
                linkGroup,
                defs;

            drawTree(jsonData);

            function drawTree(jsonData) {
                tree = d3.layout.tree().size([height, width]);

                // Make flat json into nested parent/child structure
                var dataMap = jsonData.reduce(function(map, node) {
                    map[node.measure] = node;
                    return map;
                }, {});

                var tree_json = [];
                jsonData.forEach(function(node) {
                    // find parent
                    var parent = dataMap[node.parent_node];
                    if (parent) {
                        // create child array if it doesn't exist
                        (parent.children || (parent.children = []))
                            // add node to parent's child array
                            .push(node);
                    } else {
                        // parent is null or missing
                        tree_json.push(node);
                    }
                });

                root = JSON.parse(JSON.stringify(tree_json, null, 2))[0];
                root.fixed = true;

                // Dynamically set the height of the main svg container
                // breadthFirstTraversal returns the max number of node on a same level
                // and colors the nodes
                var maxDepth = 0;
                var maxTreeWidth = breadthFirstTraversal(tree.nodes(root), function(currentLevel) {
                    maxDepth++;
                    currentLevel.forEach(function(node) {

                        if (node.value_change > 0 && config.enableComparison === true) {
                            node.color = config.positiveGrowthColor;
                            node.text_color = config.positiveGrowthTextColor;
                        } else if (node.value_change < 0 && config.enableComparison === true) {
                            node.color = config.negativeGrowthColor;
                            node.text_color = config.negativeGrowthTextColor;
                        } else if (node.value_change == 0 || node.value_change == null && config.enableComparison === true) {
                            node.color = config.noGrowthColor;
                            node.text_color = config.noGrowthTextColor;
                        } else {
                            node.color = config.noGrowthColor;
                            node.text_color = config.noGrowthTextColor;
                        }

                        if (node.value_change > 0)
                            node.arrow = '&#9650';
                        if (node.value_change < 0)
                            node.arrow = '&#9660';
                        if (node.value_change == 0 || node.value_change == null)
                            node.arrow = '&mdash;';
                    });
                });

                if (config.missyElliott === 'vertical') {
                    height = maxDepth * (rectNode.height + 100) + 100 - margin.right - margin.left;
                    width = maxTreeWidth * (rectNode.width * 1.75) - 200 - margin.top - margin.bottom;
                } else {
                    height = maxTreeWidth * (rectNode.height + 100) + 100 - margin.right - margin.left;
                    width = maxDepth * (rectNode.width * 1.5) - margin.top - margin.bottom;
                }
                
                

                tree = d3.layout.tree().size([height, width]);



                if (config.missyElliott === 'vertical') {
                    root.x0 = 0;
                    root.y0 = height / 2;
                } else {
                    root.x0 = height / 2;
                    root.y0 = 0;
                }

                baseSvg = d3.select('#tree-container').append('svg')
                    .attr('width', width + margin.right + margin.left)
                    .attr('height', height + margin.top + margin.bottom)
                    .attr('class', 'svgContainer')
                    .call(d3.behavior.zoom()
                        //.scaleExtent([0.5, 1.5]) // Limit the zoom scale
                        .on('zoom', zoomAndDrag));

                // Mouse wheel is desactivated, else after a first drag of the tree, wheel event drags the tree (instead of scrolling the window)
                getMouseWheelEvent();
                d3.select('#tree-container').select('svg').on(mouseWheelName, null);
                d3.select('#tree-container').select('svg').on('dblclick.zoom', null);

                svgGroup = baseSvg.append('g')
                    .attr('class', 'drawarea')
                    .append('g')
                    .attr('transform', 'translate(' + margin.left + ',' + margin.top + ')');

                nodeGroup = svgGroup.append('g')
                            .attr('id', 'nodes');
                linkGroup = svgGroup.append('g')
                            .attr('id', 'links');

                defs = baseSvg.append('defs');
                initArrowDef();
                initDropShadow();
                update(root);
            }

            function update(source) {

                function getTextWidth(text, font) {
                    // re-use canvas object for better performance
                    var canvas = getTextWidth.canvas || (getTextWidth.canvas = document.createElement("canvas"));
                    var context = canvas.getContext("2d");
                    context.font = font;
                    var metrics = context.measureText(text);
                    return metrics.width;
                }
                // Compute the new tree layout
                var nodes = tree.nodes(root).reverse(),
                    links = tree.links(nodes);

                // Check if two nodes are in collision on the ordinates axe and move them
                breadthFirstTraversal(tree.nodes(root), collision);
                // Normalize for fixed-depth
                nodes.forEach(function(d) {
                    if (config.missyElliott === 'vertical') {
                        d.y = d.depth * (rectNode.width);
                    } else {
                        d.y = d.depth * (rectNode.width * 1.5);
                    }
                    
                });

                // 1) ******************* Update the nodes *******************
                var node = nodeGroup.selectAll('g.node').data(nodes, function(d) {
                    return d.id || (d.id = ++i);
                });


                // Enter any new nodes at the parent's previous position
                // We use "insert" rather than "append", so when a new child node is added (after a click)
                // it is added at the top of the group, so it is drawed first
                // else the nodes tooltips are drawed before their children nodes and they
                // hide them
                var nodeEnter = node.enter().insert('g', 'g.node')
                    .attr('class', 'node')
                    .attr('transform', function(d) {
                        if (config.missyElliott === 'vertical') {
                            return 'translate(' + source.x0 + ',' + source.y0 + ')';
                        } else {
                            return 'translate(' + source.y0 + ',' + source.x0 + ')';
                        }
                    })
                    .on('click', function(d) {
                        click(d);
                    });

                var tool = d3.select("body").append("div").attr("class", "toolTip");

                nodeEnter.append('g').append('rect')
                    .attr('rx', 6)
                    .attr('ry', 6)
                    .attr('width', rectNode.width)
                    .attr('height', rectNode.height)
                    .attr('class', 'node-rect')
                    .attr('fill', function(d) {
                        return d.color;
                    })
                    .attr('arrow', function(d) {
                        return d.arrow;
                    })
                    .attr('text_color', function(d) {
                        return d.text_color;
                    })
                    .attr('filter', 'url(#drop-shadow)');

                nodeEnter.append('foreignObject')
                    .attr('x', rectNode.textMargin)
                    .attr('y', rectNode.textMargin)
                    .attr('width', function() {
                        return (rectNode.width - rectNode.textMargin * 2) < 0 ? 0 :
                            (rectNode.width - rectNode.textMargin * 2);
                    })
                    .attr('height', function() {
                        return (rectNode.height - rectNode.textMargin * 2) < 0 ? 0 :
                            (rectNode.height - rectNode.textMargin * 2);
                    })
                    .append('xhtml').html(function(d) {
                        return '<div style="width: ' +
                            (rectNode.width - rectNode.textMargin * 2) + 'px; height: ' +
                            (rectNode.height - rectNode.textMargin * 2) + 'px; font-size:0.8em; display: flex; justify-content: center; align-items: center; color:' + d.text_color + '" class="node-text wordwrap;"><center>' +
                            '<b>' + d.measure + '</b><br><br>' +
                            '<b>Value: </b>' + d.rendered_value +

                            // Show value_change dependent on config toggle
                            d.value_change_text +

                            '</center></div>';
                    })
                    .on("mousemove", function (d) {
                        tool.style("left", d3.event.pageX + 10 + "px")
                        tool.style("top", d3.event.pageY - 20 + "px")
                        tool.style("display", "inline-block");
                        tool.html('Description: ' + d.description);
                    }).on("mouseout", function (d) {
                        tool.style("display", "none");
                    });

                // Transition nodes to their new position.
                var nodeUpdate = node.transition().duration(duration)
                    .attr('transform', function(d) {
                        if (config.missyElliott === 'vertical') {
                            return 'translate(' + d.x + ',' + d.y + ')';
                        } else {
                            return 'translate(' + d.y + ',' + d.x + ')';
                        }
                    });

                nodeUpdate.select('rect')
                    .attr('class', function(d) {
                        return d._children ? 'node-rect-closed' : 'node-rect';
                    });

                nodeUpdate.select('text').style('fill-opacity', 1);

                // Transition exiting nodes to the parent's new position
                var nodeExit = node.exit().transition().duration(duration)
                    .attr('transform', function(d) { 
                        if (config.missyElliott === 'vertical') {
                            return 'translate(' + source.x + ',' + source.y + ')';
                        } else {
                            return 'translate(' + source.y + ',' + source.x + ')';
                        }
                    })
                    .remove();

                nodeExit.select('text').style('fill-opacity', 1e-6);


                // 2) ******************* Update the links *******************
                var link = linkGroup.selectAll('path').data(links, function(d) {
                    return d.target.id;
                });

                function linkType(link) {
                    return "Asynchronous [\u2192]";
                }

                d3.selection.prototype.moveToFront = function() {
                    return this.each(function() {
                        this.parentNode.appendChild(this);
                    });
                };

                // Enter any new links at the parent's previous position.
                var linkenter = link.enter().insert('path', 'g')
                    .attr('class', 'link')
                    .attr('id', function(d) { return 'linkID' + d.target.id; })
                    .attr('d', function(d) { return diagonal(d); })
                    .attr('marker-end', 'url(#end-arrow)')

                // Transition links to their new position.
                var linkUpdate = link.transition().duration(duration)
                                     .attr('d', function(d) { return diagonal(d); });
            
                // Transition exiting nodes to the parent's new position.
                link.exit().transition()
                .remove();

                // Stash the old positions for transition.
                nodes.forEach(function(d) {
                    d.x0 = d.x;
                    d.y0 = d.y;
                });
            }

            // Zoom functionnality is desactivated (user can use browser Ctrl + mouse wheel shortcut)
            function zoomAndDrag() {
                //var scale = d3.event.scale,
                var scale = 1,
                    translation = d3.event.translate,
                    tbound = -height * scale,
                    bbound = height * scale,
                    lbound = (-width + margin.right) * scale,
                    rbound = (width - margin.left) * scale;
                // limit translation to thresholds
                translation = [
                    Math.max(Math.min(translation[0], rbound), lbound),
                    Math.max(Math.min(translation[1], bbound), tbound)
                ];
                d3.select('.drawarea')
                    .attr('transform', 'translate(' + translation + ')' +
                        ' scale(' + scale + ')');
            }

            // Toggle children on click.
            function click(d) {
                if (d.children) {
                    d._children = d.children;
                    d.children = null;
                } else {
                    d.children = d._children;
                    d._children = null;
                }
                update(d);
            }

            // Breadth-first traversal of the tree
            // func function is processed on every node of a same level
            // return the max level
            function breadthFirstTraversal(tree, func) {
                var max = 0;
                if (tree && tree.length > 0) {
                    var currentDepth = tree[0].depth;
                    var fifo = [];
                    var currentLevel = [];

                    fifo.push(tree[0]);
                    while (fifo.length > 0) {
                        var node = fifo.shift();
                        if (node.depth > currentDepth) {
                            func(currentLevel);
                            currentDepth++;
                            max = Math.max(max, currentLevel.length);
                            currentLevel = [];
                        }
                        currentLevel.push(node);
                        if (node.children) {
                            for (var j = 0; j < node.children.length; j++) {
                                fifo.push(node.children[j]);
                            }
                        }
                    }
                    func(currentLevel);
                    return Math.max(max, currentLevel.length);
                }
                return 0;
            }

            // x = ordoninates and y = abscissas
            function collision(siblings) {
                var minPadding = 15;
                if (siblings) {
                    for (var i = 0; i < siblings.length - 1; i++) {

                        if (config.missyElliott === 'vertical') {
                            if (siblings[i + 1].x - (siblings[i].x + rectNode.width) < minPadding)
                                siblings[i + 1].x = siblings[i].x + rectNode.width + minPadding;
                        } else {
                            if (siblings[i + 1].x - (siblings[i].x + rectNode.height) < minPadding)
                                siblings[i + 1].x = siblings[i].x + rectNode.height + minPadding;
                        }
                        
                    }
                }
            }

            function removeMouseEvents() {
                // Drag and zoom behaviors are temporarily disabled, so tooltip text can be selected
                mousedown = d3.select('#tree-container').select('svg').on('mousedown.zoom');
                d3.select('#tree-container').select('svg').on("mousedown.zoom", null);
            }

            function reactivateMouseEvents() {
                // Reactivate the drag and zoom behaviors
                d3.select('#tree-container').select('svg').on('mousedown.zoom', mousedown);
            }

            // Name of the event depends of the browser
            function getMouseWheelEvent() {
                if (d3.select('#tree-container').select('svg').on('wheel.zoom'))
                {
                    mouseWheelName = 'wheel.zoom';
                    return d3.select('#tree-container').select('svg').on('wheel.zoom');
                }
                if (d3.select('#tree-container').select('svg').on('mousewheel.zoom') != null)
                {
                    mouseWheelName = 'mousewheel.zoom';
                    return d3.select('#tree-container').select('svg').on('mousewheel.zoom');
                }
                if (d3.select('#tree-container').select('svg').on('DOMMouseScroll.zoom'))
                {
                    mouseWheelName = 'DOMMouseScroll.zoom';
                    return d3.select('#tree-container').select('svg').on('DOMMouseScroll.zoom');
                }
            }

            function diagonal(d) {

                    if (config.missyElliott === 'vertical') {
                        var p0 = {
                            x: d.source.x + (rectNode.width / 2),
                            y: d.source.y + rectNode.height
                        };
                    } else {
                        var p0 = {
                            x: d.source.x + rectNode.height / 2,
                            y: (d.source.y + rectNode.width)
                        };
                    }
                
                    if (config.missyElliott === 'vertical') {
                        var p3 = {
                            x: d.target.x + rectNode.width / 2,
                            y: d.target.y - 12 // -12, so the end arrows are just before the rect node
                        }
                    } else {
                        var p3 = {
                            x: d.target.x + rectNode.height / 2,
                            y: d.target.y - 12 // -12, so the end arrows are just before the rect node
                        }
                    }
                    
                    var m = (p0.y + p3.y) / 2,
                    p = [p0, {
                        x: p0.x,
                        y: m
                    }, {
                        x: p3.x,
                        y: m
                    }, p3];
                p = p.map(function(d) {
                    if (config.missyElliott === 'vertical') {
                        return [d.x, d.y];
                    } else {
                        return [d.y, d.x];
                    }
                });
                return 'M' + p[0] + 'C' + p[1] + ' ' + p[2] + ' ' + p[3];
            }

            function initDropShadow() {
                var filter = defs.append("filter")
                    .attr("id", "drop-shadow")
                    .attr("color-interpolation-filters", "sRGB");

                filter.append("feOffset")
                    .attr("result", "offOut")
                    .attr("in", "SourceGraphic")
                    .attr("dx", 0)
                    .attr("dy", 0);

                filter.append("feGaussianBlur")
                    .attr("stdDeviation", 2);

                filter.append("feOffset")
                    .attr("dx", 2)
                    .attr("dy", 2)
                    .attr("result", "shadow");

                filter.append("feComposite")
                    .attr("in", 'offOut')
                    .attr("in2", 'shadow')
                    .attr("operator", "over");
            }

            function initArrowDef() {
                // Build the arrows definitions
                // End arrow
                defs.append('marker')
                    .attr('id', 'end-arrow')
                    .attr('viewBox', '0 -5 10 10')
                    .attr('refX', 0)
                    .attr('refY', 0)
                    .attr('markerWidth', 6)
                    .attr('markerHeight', 6)
                    .attr('orient', 'auto')
                    .attr('class', 'arrow')
                    .append('path')
                    .attr('d', 'M0,-5L10,0L0,5');

                // End arrow selected
                defs.append('marker')
                    .attr('id', 'end-arrow-selected')
                    .attr('viewBox', '0 -5 10 10')
                    .attr('refX', 0)
                    .attr('refY', 0)
                    .attr('markerWidth', 6)
                    .attr('markerHeight', 6)
                    .attr('orient', 'auto')
                    .attr('class', 'arrowselected')
                    .append('path')
                    .attr('d', 'M0,-5L10,0L0,5');
            }
        }

        function numberWithCommas(nStr) {
            nStr += '';
            var x = nStr.split('.');
            var x1 = x[0];
            var x2 = x.length > 1 ? '.' + x[1] : '';
            var rgx = /(\d+)(\d{3})/;
            while (rgx.test(x1)) {
             x1 = x1.replace(rgx, '$1' + ',' + '$2');
            }
            return x1 + x2;
        }


        var item = {};
        var jsonObj = [];
        // transform raw data from queryResponse into json array
        for (var row of data) {

            var measure = row[queryResponse.fields.dimensions[0].name].value;
            var parent_node = row[queryResponse.fields.dimensions[1].name].value;
            var value_number_format = row[queryResponse.fields.dimensions[2].name].value;
            var value_calc = row[queryResponse.fields.dimensions[3].name].value;
            var description = row[queryResponse.fields.dimensions[4].name].value;
            var single_value_chosen_period = row[queryResponse.fields.measures[0].name].value;
            var single_value_previous_period = row[queryResponse.fields.measures[1].name].value;
            var numerator_chosen_period = row[queryResponse.fields.measures[2].name].value;
            var numerator_previous_period = row[queryResponse.fields.measures[3].name].value;
            var denominator_chosen_period = row[queryResponse.fields.measures[4].name].value;
            var denominator_previous_period = row[queryResponse.fields.measures[5].name].value;

            item = {};
            item.measure = measure;
            item.parent_node = parent_node;
            item.value_number_format = value_number_format;
            item.value_calc = value_calc;
            item.description = description;
            item.single_value_chosen_period = single_value_chosen_period;
            item.single_value_previous_period = single_value_previous_period;
            item.single_value_pop = (single_value_chosen_period / single_value_previous_period) - 1;
            item.numerator_chosen_period = numerator_chosen_period;
            item.numerator_previous_period = numerator_previous_period;
            item.denominator_chosen_period = denominator_chosen_period;
            item.denominator_previous_period = denominator_previous_period;
            item.average_value = (numerator_chosen_period / denominator_chosen_period);
            item.average_pop = ((numerator_chosen_period / denominator_chosen_period) / (numerator_previous_period / denominator_previous_period)) - 1;

            // choose how to calculate the value whether its a sum or an average
            if (value_calc == 'sum')
                item.value_change = item.single_value_pop;
            if (value_calc == 'average')
                item.value_change = item.average_pop;
            if (value_calc == 'sum')
                item.value = item.single_value_chosen_period;
            if (value_calc == 'average')
                item.value = item.average_value;

            item.value_change_text = '';
            if (config.enableComparison === true) {
                item.value_change_text = '<br><b>PoP: </b>' + ' ' + numberWithCommas(Math.round(((item.value_change * 100) + Number.EPSILON) * 100) / 100) + '% <br>';
            }


            // render the value correctly
            if (value_number_format == 'gbp_0')
                item.rendered_value = "Â£" + numberWithCommas(Math.round(item.value));
            if (value_number_format == 'gbp')
                item.rendered_value = "Â£" + numberWithCommas(Math.round((item.value + Number.EPSILON) * 100) / 100);
            if (value_number_format == 'gbp_mill')
                item.rendered_value = "Â£" + numberWithCommas(Math.round((item.value / 100000000 + Number.EPSILON) * 10000) / 100 + "M" );
            if (value_number_format == 'gbp_thousand')
                item.rendered_value = "Â£" + numberWithCommas(Math.round((item.value / 1000 + Number.EPSILON))+ "K" );
            if (value_number_format == 'decimal_2')
                item.rendered_value = numberWithCommas(Math.round((item.value + Number.EPSILON) * 100) / 100);
            if (value_number_format == 'decimal_0')
                item.rendered_value = numberWithCommas(Math.round(item.value));
            if (value_number_format == 'percent_4')
                item.rendered_value = numberWithCommas(Math.round((item.value + Number.EPSILON) * 1000000) / 10000) + "%";
            if (value_number_format == 'percent_3')
                item.rendered_value = numberWithCommas(Math.round((item.value + Number.EPSILON) * 100000) / 1000) + "%";
            if (value_number_format == 'percent_2')
                item.rendered_value = numberWithCommas(Math.round((item.value + Number.EPSILON) * 10000) / 100) + "%";
            if (value_number_format == 'percent_1')
                item.rendered_value = numberWithCommas(Math.round((item.value + Number.EPSILON) * 1000) / 10) + "%";
            if (value_number_format == 'percent_0')
                item.rendered_value = numberWithCommas(Math.round(item.value * 100)) + "%";


            jsonObj.push(item);


        }


        // empty element
        d3.selectAll("svg").remove();

        d3.json(jsonObj, function() {

            // empty element
            d3.selectAll("svg").remove();
            treeBoxes(jsonObj);

            // We are done rendering! Let Looker know.
            done();
        });
    }
});