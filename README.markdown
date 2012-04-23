UIGuiders
=========

*Visual guiders for website UIs*
It's like "Guiders-JS", but easily customizable and less js-centric.

![Screenshot](https://github.com/snitko/ui_guiders/raw/master/Screenshot.png)

Why?
----
Because I wanted an easy soulution that wouldn't be all javascript. I don't think it's a good idea to assign
guiders on the js-level, like Guiders.js does. Instead, it should be in the views. The javascript part
only handles proper positioning and effects part, while remaining uninvolved into the styles/content business.

If you wish, you may just use the js part and use it outside of the Rails app.
(Actually, it's written in coffeescript, so you'd have to compile it first).

The javascript part will correctly determine which part of the screen the target DOM-element is positioned and
then choose how to display the guider - what side the arrow should be on and should the guider be on top or
at the bottom of the target DOM-element. No need to manually specify any options.

See Screenshot.png file for a small demonstration of how it looks.

INSTALLATION
------------

1. gem install ui_guiders

2. 
  (a) Add to your scss: `@import "ui_guiders";` OR
  (b) Add to your layout: `stylesheet_link_tag 'ui_guiders'`

3.
  (a) Add to your application.js.coffee `#= require lib/ui_guiders` OR
  (b) Add to your layout: `javascript_include_tag "lib/ui_guiders"`


Usage
-----

This is what you put in your views (haml example):

    = ui_guider :target => "header .menuItem1", :autoshow => true, :event => "click", :show_once => true, :id => "menu_item_1_guider", :class => "myclass" do
        text explaining
        this awesome menuitem

That's it. Now when your page is loaded a shiny yellow guider will appear pointing at the DOM element you specified with the :target option.
Other options explanation:

`:autoshow`    if true, js-part of the plugin will force the guider to appear up
               immediately after the page loads. Default is false.

`:autohide`    if true, it hides the guider whenever the `mouseout` event happens on the target element.
               The close ico does not appear if this option is enabled (because this option also adds `autohide` class to
               the .uiGuider element, and default css sets a `display` property of `img.close` in it to `none`).

`:show_once`   Saves cookie with the id of the guider. Next time the user visits, the guider is not shown.
               Default is false.

`:event`       jQuery event (for example `click` or `mouseover`) which is binded to the target and on which the guider is shown.

`:side_arrow`  Normally the arrow would appear either on top or the bottom side of the guider, but with this option set to true, you can an arrow
               on either left or right side of the guider. Use with caution, as this may force horizontal scrollbars to appear if your targer is
               placed to close the edge of the screen.

`:target_edge` Sets a horizontal location on the target for the arrow to point to, possible values are "left", "right" or "middle"
               (default is "middle").

`:id`
`:class`       Both are applied to the html-element.


Customization
-------------
* Want different styles?
  copy `app/assets/stylesheets/ui_guiders.css.scss` from the gem dir and change it.

* Replacing images?
  You guessed it right. Copy `app/assets/images/ui_guiders/` from the gem dir and change it.

For images and stylesheets make sure your `app/assets` dir loads last, so that Rails loads *your* files.
I managed to do it with

    config.assets.paths << "#{Rails.root}/app/assets/stylesheets/" 
    config.assets.paths << "#{Rails.root}/app/assets/images/"

in my `config/application.rb`

* Want a different markup?
  copy `app/assets/views/shared/_ui_guider.haml` from the plugin dir and change it.


Requirements
------------

  * Rails 3.1 (sorry, no 3.0 support, using assets)
  * jQuery (tested on 1.5.2)
  * jquery.cookie.js 
