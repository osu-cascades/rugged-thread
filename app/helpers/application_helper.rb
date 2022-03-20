module ApplicationHelper
  include Pagy::Frontend

  def pagination_nav(pagy, prev_path, next_path)
    render 'shared/pagination_nav', { pagy: pagy, prev_path: prev_path, next_path: next_path }
  end
end
