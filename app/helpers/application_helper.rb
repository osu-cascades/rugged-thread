module ApplicationHelper
  include Pagy::Frontend

  def pagination_nav(pagy, prev_path, next_path)
    render 'shared/pagination_nav', { pagy: pagy, prev_path: prev_path, next_path: next_path }
  end

  def archived?(object)
    if object.kept?
      return button_to 'Archive', archive_customer_path(object), method: :patch, class: 'btn btn-outline-success me-2'
    else
      return button_to 'Recover', recover_customer_path(object), method: :patch, class: 'btn btn-outline-success me-2'
    end
  end
end
