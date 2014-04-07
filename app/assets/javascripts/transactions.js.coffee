ready =  ->
  $('#transaction_datepicker').datepicker({dateFormat:'dd-mm-yy'})

$(document).ready(ready)
$(document).on('page:load', ready)