

function generatePairsOnDate(date) {

  $.ajax({
    type: "POST",
    url: "/pairs/generate_pairs",
    data: JSON.stringify({ date: date }),
    contentType: "application/json",
    dataType: "json" })

    .done(function(data) {

      console.log(data);
      var date = data[0].date;

      if (data.length > 0) {
        var dayGroup = $("<ul></ul>", {"class": "list-group", "id": "day-group"});
        var titleItem = $("<li></li>", {"class": "list-group-item", "id": "day-group-title-item"});

        titleItem.html(`<b>${date}</b>`);
        dayGroup.append(titleItem);

        for (var pair of data) {
          var combi = pair.students;
          var pairItem = $("<li></li>", {"class": "list-group-item", "id": "day-group-pair-item"});

          pairItem.html(combi);
          dayGroup.append(pairItem);
        }
      $("#main-list").prepend(dayGroup);

      $("#generate-button").removeAttr('disabled');
      }
    })

    .fail(function(error) {
      console.log(error); });
}






function submitGeneratePairs(event){
  event.preventDefault();

  //Aaaargh Javascript!!!!!!
  var dateObj = $("#generate-date").children();
  var year = $(dateObj[0]);
  var month = $(dateObj[1]);
  var day = $(dateObj[2]);

  var date = {"date(1i)": year.val(), "date(2i)": month.val(), "date(3i)": day.val()};

  generatePairsOnDate(date);

}



$(document).ready(function() {
  $("#generate-form").bind('submit', submitGeneratePairs);
});

// console.log('loaded')
