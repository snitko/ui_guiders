jQuery ($) ->

  window.UIGuider = class UIGuider
      
    constructor: (block) ->
      @block        = $(block)
      @target       = $($(@block).attr("data-target-element"))
      @arrows = {
        top:    @block.children(".arrow.top")
        bottom: @block.children(".arrow.bottom")
        left:   @block.children(".arrow.side.left")
        right:  @block.children(".arrow.side.right")
      }
      @state = "hidden"

      @hide_arrows = () ->
        for a in @arrows
          a.hide()

      # Places arrow to the right corner of the Guider.
      # It's top/bottom and left/right position is always equal to that
      # of a target.
      @place_arrow = (pos, options={}) ->
        @hide_arrows()
        if options.side_arrow
          @arrows[pos.x].css(top: @block.height()/2 - @arrows.left.height()).show()
        else
          @arrows[pos.y].show().addClass(pos.x)
        
      # Places Guider so that its arrow always points to the target.
      # Depending on the position of the target the guider will appear on the left
      # or on the right side of the target.
      #
      # To set a horizontal location on the target for the arrow to point to,
      # use "edge" option for that with "left", "right" or "middle" (default is "middle").
      #
      # To set the type of arrow (side arrow or arrows appearing on the top or the bottom of the guider),
      # set "side_arrow" option to true.
      @place_guider = (pos, options={}) ->

        if options.side_arrow
          arrow = @arrows.left
          arrow_offset_sign = 1
        else
          arrow = @arrows.top
          arrow_offset_sign = -1

        if options.side_arrow
          top_offset = @target.offset().top + @target.height()/2 - @block.height()/2
        else if pos.y == "top"
          top_offset = @target.offset().top + @target.height() + arrow.height()
        else
          top_offset = @target.offset().top - @block.height() - arrow.height()

        if pos.x == "left"
          pos_left_offset = @target.offset().left + arrow.width()*arrow_offset_sign
          if options.edge == "left"
            width_left_offset = 0
          else if options.edge == "right"
            width_left_offset = @target.width()
          else
            width_left_offset = @target.width()/2
        else
          arrow_offset_sign = -arrow_offset_sign
          pos_left_offset = @target.offset().left + arrow.width()*arrow_offset_sign
          if options.edge == "left"
            width_left_offset = -@block.width()
          else if options.edge == "right"
            width_left_offset = -@block.width() + @target.width()
          else
            width_left_offset = -@block.width() + @target.width()/2


        @block.css { top: top_offset }
        @block.css { left: pos_left_offset + width_left_offset }


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

    show: (options={}) ->
      UIGuidersCollection.hide_all()
      return if $.cookie("UIGuider_#{@block.attr("id")}")

      options["side_arrow"]  = true                            if @block.hasClass("side_arrow")
      options["edge"]        = @block.attr("data-target-edge") if @block.attr("data-target-edge")
      @target = options.target   

      @place_arrow  @target_location(), options
      @place_guider @target_location(), options

      @set_cookie()
      @block.find(".content").html(options["content"]) if options["content"]
      @block.fadeIn(500)
      @state = "visible"

    hide: () ->
      @block.hide()
      @state = "hidden"
  

  class _UIGuidersCollection


    constructor: () ->
    
      @ui_guiders = []
      for g in $(".uiGuider")
        @ui_guiders.push new UIGuider(g)

      for g in @ui_guiders
        if g.block.hasClass("autoshow")
          setTimeout () ->
            g.show()
          , 1000

        if g.block.hasClass("autohide")
          g.target.bind "mouseout", { guider: g }, (event) ->
            event.data.guider.hide()
        
        if g.block.attr("data-event-name") && g.block.attr("data-event-name").length > 0
          g.target.bind g.block.attr("data-event-name"), { guider: g }, (event) =>
            event.data.guider.show(target: $(event.currentTarget)) unless event.data.guider.state == "visible"

        g.block.find(".close").click () ->
          g.hide()


    find: (id) ->
      result = null
      for guider in @ui_guiders
        result = guider if guider.block.attr("id") == id
      result

    hide_all: () ->
      for guider in @ui_guiders
        guider.hide()


  window.UIGuidersCollection = new _UIGuidersCollection()
