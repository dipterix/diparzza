module StaffsHelper
  def staffs_error_messages!
    return "" if @staff.errors.empty?

    messages = @staff.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      count: @staff.errors.count,
                      resource: @staff.class.model_name.human.downcase)

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
