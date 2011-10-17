jQuery ($) ->

  window.UIGuider = class UIGuider
      
    constructor: (block) ->
      @block        = $(block)
      @target       = $($(@block).attr("data-target-element"))
      @top_arrow    = @block.children(".arrow.top")
      @bottom_arrow = @block.children(".arrow.bottom")
      @state = "hidden"

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

        @block.css { top: top_offset }
        @block.css { left: left_offset }


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
      for guider in ui_guiders
        guider.hide()
      return if $.cookie("UIGuider_#{@block.attr("id")}")
      @place_arrow  @target_location()
      @place_guider @target_location()
      @set_cookie()
      @block.fadeIn(500)
      @state = "visible"

    hide: () ->
      @block.hide()
      @state = "hidden"
  

  ui_guiders = []
  $(".uiGuider").each () ->
    g = new UIGuider($(this)); ui_guiders.push g
    if g.block.hasClass("autoshow")
      setTimeout () ->
        g.show()
      , 1000
    if g.block.attr("data-event-name").length > 0
      g.target.bind g.block.attr("data-event-name"), () ->
        g.show() unless g.state == "visible"
      g.block.find(".close").click () ->
        g.hide()

