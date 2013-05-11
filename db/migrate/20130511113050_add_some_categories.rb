class AddSomeCategories < ActiveRecord::Migration
  def up
    ['eye-shadow', 'lip balms', 'mascara', 'moisturizing cream', 'scrub',
     'low-fat cream', 'tonic', 'lotions', 'make-up lotion'].each do |category|
      Category.create(title: category)
    end
    puts 'done'
  end

  def down
  end
end
