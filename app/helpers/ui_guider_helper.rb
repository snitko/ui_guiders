module UiGuiderHelper

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
    options[:class] += " autoshow"  if     options[:autoshow]
    options[:class] += " show_once" if     options[:show_once]
    render :partial => "shared/ui_guider", :locals => { :content => content, :options => options }
  end

end
