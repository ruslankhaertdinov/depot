module StoreHelper
  def current_path(id)
    Category.where(id: id).first.title_ru
  end
end
