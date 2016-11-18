$.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: 'graphs/step_data',
        dataType: 'json',
        success: function (data) {
          drawSteps(data);
        },
        error: function (result) {
          error();
        }
      });

function drawSteps(data) {
  var margin = {top: 20, right: 30, bottom: 30, left: 40};
  var width = 960 - margin.left - margin.right;
  var height = 400 - margin.top - margin.bottom;

  var x = d3.scaleBand().rangeRound([0, width]);
  var y = d3.scaleLinear().range([height, 0]);
  var xAxis = d3.axisBottom().scale(x);
  var yAxis = d3.axisLeft().scale(y);

  var div = d3.select("body").append("div")
    .attr("class", "tooltip")
    .style("opacity", 0);

  var chart = d3.select(".step-chart")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  x.domain(data.map(function(d) { return d.date; }));
  y.domain([0, d3.max(data, function(d) { return d.steps; })]);

  chart.append("g")
    .attr("class", "y axis")
    .call(yAxis);

  chart.append("text")
    .attr("class", "axis-label")
    .attr("transform", "rotate(-90)")
    .attr("y", 0 - margin.left)
    .attr("x", 0 - (height / 2))
    .attr("dy", "1em")
    .style("text-anchor", "middle")
    .text("Steps walked");

  chart.selectAll(".bar")
    .data(data)
    .enter().append("rect")
    .attr("class", "bar")
    .attr("x", function(d) { return x(d.date); })
    .attr("y", function(d) { return y(d.steps); })
    .attr("height", function(d) { return height - y(d.steps); })
    .attr("width", 5)
    .on('mouseover', function(d) {
      d3.select(this)
        .style('fill', '#94A7AD');
      div.transition()
        .duration(200)
        .style("opacity", .9);
      div.html(d.date + '<br/>' + d.steps)
        .style("left", (d3.event.pageX) + "px")
        .style("top", (d3.event.pageY - 28) + "px");
    })
    .on('mouseout', function(d) {
      d3.select(this)
        .style('fill', '#8A735B');
      div.transition()
        .duration(500)
        .style("opacity", 0);
    });

  chart.append("text")
    .attr("class", "chart-title")
    .attr("x", (width / 2))
    .attr("y", 0 - (margin.top / 2))
    .attr("text-anchor", "middle")
    .text("Steps Walked per Day");
}
