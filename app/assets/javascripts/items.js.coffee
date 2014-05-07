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
  $('.item_thumb').each ->
    $(this).qtip
      content:
        text: '<img src="' + $(this).attr('href') + '"/>'
      style:
        classes: 'qtip-plain qtip-bootstrap'

    $('.item_user_link').each ->
      $(this).qtip
        style:
          classes: 'qtip-plain qtip-bootstrap'
        content:
          title: $(this).data('username')
          text: "<dl class='item_user_tooltip'>" +
                  "<dt>Points:</dt><dd>" + $(this).data('points') + "</dd>" +
                  "<dt>Date Joined:</dt><dd>" + $(this).data('joined') + "</dd>" +
                "</dl>"



$(document).ready(ready)
$(document).on('page:load', ready)