class GraphBuilder

  def initialize
  end

  def show_countries(user)
    @countries = Array.new
    @countries << ["Country", "Nr. vinks"]
    countries = Country.all
    countries.each do |country|
      @countries << ["#{country.country}", user.vinks.joins(:club).where("clubs.country_id = ?", country.id).count]
    end
    @countries
  end

end


=begin


    :javascript
      google.load('visualization', '1.0', {'packages':['corechart']});
      google.setOnLoadCallback(drawChartCountries);
      function drawChartCountries() {
        // Create and populate the data table.
        var data_countries = google.visualization.arrayToDataTable(#{@countries});

        // Create and draw the visualization.
        new google.visualization.PieChart(document.getElementById('countries_chart_div')).draw(data_countries,
          {width:350, height:350, chartArea: {left:60,top:0}, colors: ['#757370','#C41D21'],pieSliceText: "value",legend: {position: 'bottom',
           textStyle: {color: 'black', fontSize: 12}}}
        );
      }

    #countries_chart_div


rescue

:javascript
  google.load('visualization', '1.0', {'packages':['corechart']});
  google.setOnLoadCallback(drawChartBonus);
  function drawChartBonus() {
    // Create and populate the data table.
    var data_hours = new google.visualization.arrayToDataTable(#{@bonus_hours});

    // Create and draw the visualization.
    new google.visualization.ColumnChart(document.getElementById('hours_chart_div')).draw(data_hours,
      { width:750, height:320, colors: ['#C41D21','#757370'], stacked: true,chartArea: {left: 50, top: 25},
        legend: {position: 'bottom', alignment: 'center',
        textStyle: {color: 'black', fontSize: 12}}}
    );
  }

#hours_chart_div


 => e

=end