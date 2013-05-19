module StoreHelper
  def current_path(id)
    @category ||= Category.where(id: id).first
    if @category
      @category.title_ru
    else
      @category
    end
  end
end
