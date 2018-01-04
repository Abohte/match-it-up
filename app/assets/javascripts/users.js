function toggleAdmin() {
  var checkbox = this;
  var listItem = $(this).parent().parent();

  var userId = listItem.data('id');
  var isAdmin = !listItem.hasClass("Admin");

  $.ajax({
    type: "PUT",
    url: "/users.json",
    data: JSON.stringify({
      user: { user: userId, admin: isAdmin }
    }),
    contentType: "application/json",
    dataType: "json"
  })
  .done(function(data) {
    console.log(data);

    listItem.toggleClass("Admin", data.admin)
  });
}

$(document).ready(function() {
  $("input[type=checkbox]").bind('change', toggleAdmin);
});
