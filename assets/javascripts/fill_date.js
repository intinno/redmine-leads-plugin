
function fillDates(elem) {
  var index = elem.selectedIndex;
  var date_range = $('date-range-'+index).innerHTML;
  var start_date = date_range.split(",")[0];
  var end_date = date_range.split(",")[1];
  $('from').value = start_date;
  $('to').value = end_date;
}

function fillEventDates(elem) {
  var index = elem.selectedIndex;
  var date_range = $('date-range-'+index).innerHTML;
  var start_date = date_range.split(",")[0];
  var end_date = date_range.split(",")[1];
  $('note_from').value = start_date;
  $('note_to').value = end_date;
}
