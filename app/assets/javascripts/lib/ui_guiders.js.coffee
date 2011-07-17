jQuery ($) ->

  window.UIGuider = class UIGuider
      
    constructor: (@block) ->
      @target       = $(@block.attr("data-target-element"))
      @top_arrow    = @block.children(".arrow.top")
      @bottom_arrow = @block.children(".arrow.bottom")

      # Places arrow to the right corner of the Guider.
      # It's top/bottom and left/right position is always equal to that
      # of a target.
      @place_arrow = (pos) ->
        if pos.y == "bottom"
          @top_arrow.hide(); @bottom_arrow.show().addClass(pos.x)
        else
          @top_arrow.addClass(pos.x)
        
      # Places Guider so that its arrow always points to the target.
      # It will point to either the top or the bottom border of the target
      # right in the middle of it.
      @place_guider = (pos) ->
        if pos.y == "top"
          top_offset = @target.offset().top + @target.height() + @block.children(".arrow").height()
        else
          top_offset = @target.offset().top - @block.height() - @block.children(".arrow").height()

        if pos.x == "left"
          left_offset = @target.offset().left + @target.width()/2 - @block.children(".arrow").width() 
        else
          left_offset = @target.offset().left - @block.width() - @block.children(".arrow").width() + @target.width()/2
          
        @block.offset
          top: top_offset
          left: left_offset

      @set_cookie = () ->
        $.cookie("UIGuider_#{@block.attr("id")}", "1", { expires: 3560 }) if @block.hasClass("show_once") and @block.attr("id")

      # Finds which part of the screen the target is located,
      # top/bottom and left/right. It is later used to position
      # the Guider and its arrow.
      @target_location = () ->
        return @target_location_cached if @target_location_cached
        if $(document).width()/2  - @target.offset().left < 0
          x = "right"
        else
          x = "left"
        if $(document).height()/2 - @target.offset().top  < 0
          y = "bottom"
        else
          y = "top"
        @target_location_cached = { x: x, y: y }

    show: () ->
      return if $.cookie("UIGuider_#{@block.attr("id")}")
      @place_arrow  @target_location()
      @place_guider @target_location()
      @set_cookie()
      @block.fadeIn(500)

    hide: () ->
      @block.hide()
  


  setTimeout () ->
    $(".uiGuider.autoshow").each () ->
      guider = new UIGuider($(this))
      guider.show()
  , 1000

  $(".uiGuider .close").click () ->
    $(this).parent().hide()
