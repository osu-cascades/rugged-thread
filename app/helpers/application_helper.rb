module ApplicationHelper
  include Pagy::Frontend

  def pagination_nav(pagy, prev_path, next_path)
    render 'shared/pagination_nav', { pagy: pagy, prev_path: prev_path, next_path: next_path }
  end

  def link_to_archive_or_recover(object)
    action_name = object.kept? ? 'Archive' : 'Recover'
    button_to action_name, send("#{action_name.downcase}_#{object.class.name.underscore}_path", object), method: :patch, class: 'btn btn-outline-success me-2'
  end
end
