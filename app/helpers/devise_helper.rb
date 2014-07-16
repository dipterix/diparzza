module DeviseHelper
  # Overwrite DeviseHelper in ~/.rvm/gems/ruby-2.1.2/gems/devise-3.2.4/app/helpers
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="notification-pane alert alert-info">
    <div id="error_explanation">
      <span>O.o</span> <!--#{sentence}-->
      <small><ul>#{messages}</ul></small>
    </div>
    </div>
    HTML

    html.html_safe
  end
end