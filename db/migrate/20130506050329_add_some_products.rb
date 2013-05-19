class AddSomeProducts < ActiveRecord::Migration
  PRODUCTS = [
      {title: 'Soap consectetur',
       description:
           %{Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum},
       image_url: 'dlya-litsa-i-tela-maski-dlya-litsa-i-tela--foto-carousel.jpg',
       price: 9.9},
      {title: 'Amet natus sit',
       description:
           %{Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur},
       image_url: 'dlya-vann-morskaya-sol-mertvogo-morya--foto-carousel.jpg',
       price: 9.9},
      {title: 'Omnis eius modi tempora',
       description:
           %{Sadipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur},
       image_url: 'dlya-vann-suhoe-molochko-dlya-vannyi--foto-carousel.jpg',
       price: 9.5},
      {title: 'Quia pursues loves',
       description:
           %{But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful.},
       image_url: 'myilo-ruchnoj-rabotyi-s-aromatami-izvestnyih-brendov--foto-carousel.jpg',
       price: 11.05},
      {title: 'Tempora dignissimos',
       description:
           %{Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him som},
       image_url: 'myilo-ruchnoj-rabotyi-s-naturalnyimi-dobavkami--foto-carousel.jpg',
       price: 12.00},
      {title: 'Accusamus blanditiis',
       description:
           %{Iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio},
       image_url: 'myilo-ruchnoj-rabotyi-seriya-love-is--foto-carousel.jpg',
       price: 10.05}

  ]

  def up
    PRODUCTS.each do |product|
      Product.create!(product)
      puts "#{product[:title]} was created"
    end
    puts "done"
  end

  def down
  end
end
