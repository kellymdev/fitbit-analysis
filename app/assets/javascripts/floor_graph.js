$.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: 'graphs/floor_data',
        dataType: 'json',
        success: function (data) {
          drawFloors(data);
        },
        error: function (result) {
          error();
        }
      });

function drawFloors(data) {
  var margin = {top: 20, right: 30, bottom: 30, left: 40};
  var width = 960 - margin.left - margin.right;
  var height = 400 - margin.top - margin.bottom;

  var x = d3.scaleBand().rangeRound([0, width]);
  var y = d3.scaleLinear().range([height, 0]);
  var xAxis = d3.axisBottom().scale(x).ticks(d3.timeMondays, 1);
  var yAxis = d3.axisLeft().scale(y);

  var chart = d3.select(".floor-chart")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  x.domain(data.map(function(d) { return d.date; }));
  y.domain([0, d3.max(data, function(d) { return d.floors; })]);

  chart.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis)
    .selectAll("text")
    .style("text-anchor", "end")
    .attr("dx", "-.8em")
    .attr("dy", "-.55em")
    .attr("transform", "rotate(-90)" );

  chart.append("g")
    .attr("class", "y axis")
    .call(yAxis)
    .append("text")
    .attr("transform", "rotate(-90)")
    .attr("y", 6)
    .attr("dy", ".71em")
    .style("text-anchor", "end")
    .text("Floors climbed");

  chart.selectAll(".bar")
    .data(data)
    .enter().append("rect")
    .attr("class", "bar")
    .attr("x", function(d) { return x(d.date); })
    .attr("y", function(d) { return y(d.floors); })
    .attr("height", function(d) { return height - y(d.floors); })
    .attr("width", 5)
    .on('mouseover', function(data) {
      d3.select(this)
      .style('fill', '#596E7C')
    })
    .on('mouseout', function(data) {
      d3.select(this)
      .style('fill', '#8A735B')
    });
}

function type(d) {
  d.value = +d.value;
  return d;
}


