module DeviseHelper
  
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:div, msg) }.join
    
    #sentence = I18n.t("errors.messages.not_saved",
    #  :count => resource.errors.count,
    #  :resource => resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="alert alert-error">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <h4>Oh snap!</h4>
    <div style="margin-left: 0px;">#{messages}</div>
    </div>
    HTML

    html.html_safe
  end
  
end
