ready = ->
  $container = $('#items_index')
  $container.imagesLoaded ->
    $container.masonry(
      gutterWidth: 1
      columnWidth: 10
      itemSelector: '.items_index_item'
    )
  $container.masonry('reload')

$(document).ready(ready)
$(document).on('page:load', ready)