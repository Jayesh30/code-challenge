module ApplicationHelper

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object)
    yield presenter if block_given?
    presenter
  end

  def bootstrap_class_for(flash_type)
    {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-info"
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def form_errors(object)
    Rails.logger.info "form_errors :  #{object.inspect} - #{object.errors.full_messages.inspect}"
    render('shared/form_errors', object: object)
  end
  
end
