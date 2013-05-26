module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end

  def thumb_for(product)
    if product && product.image_url && product.image_url.thumb.present?
      product.image_url.thumb
    else
      'thumb_placeholder.jpg'
    end
  end

  def formatted_currency(sum)
    number_to_currency(sum, unit: "$", format: "%u%n")
  end
end
