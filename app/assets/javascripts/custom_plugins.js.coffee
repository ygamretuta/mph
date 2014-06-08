(($) ->
  $.fn.doublepostpreventer = ->
    @find('form').andSelf().filter('form').submit ->
      $form = $(this)
      all_submit_handlers = $(form).data('events').submit

      if all_submit_handlers isnt `undefined` and all_submit_handlers.length is 1
        $form.find("input[type=submit]").attr "disabled", "disabled"
        console.log "disabling"
      return
    return
) jQuery