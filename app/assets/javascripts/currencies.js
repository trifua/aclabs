$( document ).ready(function() {

  $.get("/currencies/generate_chart", function(data){
    var chart = c3.generate({
        data: {
            columns:
              data["owned_currencies"],
            type : 'donut'
        },
        donut: {
            title: "Your Currency Portofolio"
        }
    });

  })
setInterval(
  $.get("/currencies/generate_chart", function(data){
    var chart = chart.load({
        data: {
            columns:
              data["owned_currencies"],
        },

    });

  }),2000)
});
