module UiGuidersHelper

  def ui_guider(options={}, &block)
    return if cookies["UIGuider_#{options[:id]}"] 
    if block_given?
      content = capture(&block)
    elsif options[:template]
      content = render(options[:template])
    else
      content = options[:text].html_safe
    end
    options[:class] = ""            unless options[:class]
    options[:class] += " autoshow"   if     options[:autoshow]
    options[:class] += " autohide"   if     options[:autohide]
    options[:class] += " show_once"  if     options[:show_once]
    options[:class] += " side_arrow" if     options[:side_arrow]
    render :partial => "shared/ui_guider", :locals => { :content => content, :options => options }
  end

end
