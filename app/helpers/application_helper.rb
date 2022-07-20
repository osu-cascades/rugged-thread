module ApplicationHelper
  include Pagy::Frontend

  def pagination_nav(pagy, prev_path, next_path)
    render 'shared/pagination_nav', { pagy: pagy, prev_path: prev_path, next_path: next_path }
  end

  def link_to_archive_or_recover(object)
    action_name = object.kept? ? 'Archive' : 'Recover'
    button_to action_name, send("#{action_name.downcase}_#{object.class.name.underscore}_path", object), method: :patch, class: 'btn btn-outline-success me-2'
  end

  def qb_link_to_archive_or_recover(object)
    action_name = object.active? ? "Archive" : "Recover"
    button_to action_name, send("#{action_name.downcase}_quickbooks_customer_path", object.id), method: :patch, class: "btn btn-outline-success me-2"
  end

  def present_address_city_state_zip(city, state, zip)
    if city.blank? && state.blank?
      zip
    elsif city.blank? && state.present?
      "#{state} #{zip}"
    elsif city.present? && state.blank?
      "#{city} #{zip}"
    else
      "#{city}, #{state} #{zip}"
    end
  end

  def filterable_model_list_title(title)
    if params[:status] == 'invoiced'
      "Invoiced #{title}"
    elsif params[:show_archive] == 'true'
      "Archived #{title}"
    else
      title
    end
  end

end
