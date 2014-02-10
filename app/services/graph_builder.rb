class GraphBuilder

  def initialize
  end

  def show_countries(user)
    @countries = Array.new
    @countries << ["Country"]
    countries = Country.all
    countries.each do |country|
      @countries << ['#{country.name}', user.vinks.joins(:club).where("clubs.country_id = ?", country.id).count]
    end
    return @countries
  end

end


=begin

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