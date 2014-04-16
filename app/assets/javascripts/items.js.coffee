ready =  ->
  pictureFieldsCount = undefined
  maxPictureFieldsCount = 5
  $addPictureLink = $('#nested_pictures + a.add_nested_fields')

  toggleAddPictureLink = ->
    $addPictureLink.toggle pictureFieldsCount < maxPictureFieldsCount

  $(document).on 'nested:fieldAdded:pictures', ->
    pictureFieldsCount += 1
    toggleAddPictureLink()

  $(document).on 'nested:fieldRemoved:pictures', ->
    pictureFieldsCount -= 1
    toggleAddPictureLink()

  pictureFieldsCount = $('#nested_pictures .fields').length
  toggleAddPictureLink()

  # tooltip
  $('#items_index').tooltip
    items: 'a.item_thumb'
    content: ->
      position:
        my: "center bottom-20"
        at: "center top"
      element = $(this)
      return '<img class="th" src="' + element.attr('href') + '"/>'

$(document).ready(ready)
$(document).on('page:load', ready)