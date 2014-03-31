$(document).on "focus", "[data-behaviour~='datepicker']", (e) ->
 - $(this).datepicker
 - format: "dd-mm-yyyy"
 - weekStart: 1
 - autoclose: true