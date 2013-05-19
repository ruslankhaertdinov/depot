module StoreHelper
  def current_path(id)
    @category ||= Category.where(id: id).first
    @category.formatted_title if @category
  end
end
