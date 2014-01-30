$ ->
  pictureFieldsCount = undefined
  pointerFieldsCount = undefined
  maxPictureFieldsCount = 5
  maxPointerFieldsCount = 5

  $addPointerLink = $('#nested_pointers + a.add_nested_fields')
  $addPictureLink = $('#nested_pictures + a.add_nested_fields')

  toggleAddPointerLink = ->
    $addPointerLink.toggle pointerFieldsCount < maxPointerFieldsCount
  toggleAddPictureLink = ->
    $addPictureLink.toggle pictureFieldsCount < maxPictureFieldsCount

  $(document).on 'nested:fieldAdded:pictures', ->
    pictureFieldsCount += 1
    toggleAddPictureLink()

  $(document).on 'nested:fieldRemoved:pictures', ->
    pictureFieldsCount -= 1
    toggleAddPictureLink()

  $(document).on 'nested:fieldAdded:pointers', ->
    pointerFieldsCount += 1
    toggleAddPointerLink()

  $(document).on 'nested:fieldRemoved:pointers', ->
    pointerFieldsCount -= 1
    toggleAddPointerLink()

  pictureFieldsCount = $('#nested_pictures .fields').length
  pointerFieldsCount = $('#nested_pointers .fields').length
  toggleAddPictureLink()
  toggleAddPointerLink()