$.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: 'graphs/activity_data',
        dataType: 'json',
        success: function (data) {
          drawActivityStack(data);
        },
        error: function (result) {
          error();
        }
      });

function drawActivityStack(data) {
  var margin = {top: 20, right: 100, bottom: 30, left: 40};
  var width = 960 - margin.left - margin.right;
  var height = 400 - margin.top - margin.bottom;

  var x = d3.scaleBand().rangeRound([0, width]);
  var y = d3.scaleLinear().rangeRound([height, 0]);
  var colour = d3.scaleOrdinal().range(["#D7C8B8", "#94A7AD", "#8A735B", "#596E7C"]);

  var xAxis = d3.axisBottom().scale(x);
  var yAxis = d3.axisLeft().scale(y);

  var chart = d3.select(".activity-chart-stacked")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  colour.domain(d3.keys(data[0]).filter(function(key) { return key !== "date"; }));

  data.forEach(function(d) {
    var y0 = 0;
    d.activity = colour.domain().map(function(name) { return {name: name, y0: y0, y1: y0 += +d[name]}; });
    d.total = d.activity[d.activity.length - 1].y1;
  });

  x.domain(data.map(function(d) { return d.date; }));
  y.domain([0, d3.max(data, function(d) { return d.total; })]);

  chart.append("g")
    .attr("class", "y axis")
    .call(yAxis)
    .append("text")
    .attr("transform", "rotate(-90)")
    .attr("y", 6)
    .attr("dy", ".71em")
    .style("text-anchor", "end")
    .text("Minutes");

  var activity = chart.selectAll(".date")
    .data(data)
    .enter().append("g")
    .attr("class", "g")
    .attr("transform", function(d) { return "translate(" + x(d.date) + ",0)"; });

  activity.selectAll("rect")
    .data(function(d) { return d.activity; })
    .enter().append("rect")
    .attr("width", 5)
    .attr("y", function(d) { return y(d.y1); })
    .attr("height", function(d) { return y(d.y0) - y(d.y1); })
    .style("fill", function(d) { return colour(d.name); });

  var legend = chart.selectAll(".legend")
    .data(colour.domain().slice().reverse())
    .enter().append("g")
    .attr("class", "legend")
    .attr("transform", function(d, i) { return "translate(0," + i * 20 + ")"; });

  legend.append("rect")
    .attr("x", width - 18)
    .attr("width", 18)
    .attr("height", 18)
    .style("fill", colour);

  legend.append("text")
    .attr("x", width - 24)
    .attr("y", 9)
    .attr("dy", ".35em")
    .style("text-anchor", "end")
    .text(function(d, i) {
      switch (i) {
        case 0: return "Very active";
        case 1: return "Fairly active";
        case 2: return "Lightly active";
        case 3: return "Sedentary";
      }
  });

  chart.append("text")
    .attr("class", "chart-title")
    .attr("x", (width / 2))
    .attr("y", 0 - (margin.top / 2))
    .attr("text-anchor", "middle")
    .text("Active Minutes per Day");
}
