# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
DynamicImage =
  replace_image: (version) ->
    old_image = $("img").attr('src')
    new_image = old_image.replace /_\d+\.jpg/, (match) -> '_' + version + '.jpg'
    $("img").attr('src', new_image)

jQuery ->
  $(".comments li").hover(
    -> DynamicImage.replace_image($(this).attr('card-version')),
    -> DynamicImage.replace_image($("img").attr('card-version'))
  )
