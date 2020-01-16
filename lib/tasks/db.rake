namespace :db do
  desc "Juice Seeds"
  task seed_juice: :environment do


    #### Adding Necessary Taxonomies ####


    if Spree::Taxon.where(name:"Build").empty?
   Spree::Taxon.create!(name: "Build", id: 999)
  end
       if Spree::Taxon.where(name:"Boxes").empty?
   Spree::Taxon.create!(name: "Boxes", id: 998)
  end
       if Spree::Taxon.where(name:"Green Box").empty?
   Spree::Taxon.create!(name: "Green Box", id: 997)
  end
       if Spree::Taxon.where(name:"Red Box").empty?
   Spree::Taxon.create!(name: "Red Box", id: 996)
  end
       if Spree::Taxon.where(name:"Yellow Box").empty?
   Spree::Taxon.create!(name: "Yellow Box", id: 995)
  end
       if Spree::Taxon.where(name:"Extras").empty?
   Spree::Taxon.create!(name: "Extras", id: 994)
  end
       if Spree::Taxon.where(name:"first").empty?
   Spree::Taxon.create!(name: "first", id: 993)
  end
       if Spree::Taxon.where(name:"second").empty?
   Spree::Taxon.create!(name: "second", id: 992)
  end
       if Spree::Taxon.where(name:"third").empty?
   Spree::Taxon.create!(name: "third", id: 991)
  end

      if Spree::Taxon.where(name:"Juices").empty?
   Spree::Taxon.create!(name: "Juices", id: 990)
  end

  ### Adding Necessary Products ####

     if Spree::Product.where(name:"Add On").empty?
Spree::Product.create!(name: "Add On", slug: "add-on", available_on: "2017-09-30 16:00:00", dynamic_variants: true, price: 20.00, shipping_category_id: 1, promotionable: true, description2: "addon")


end
     if Spree::Product.where(name:"Build Your Own Box").empty?
Spree::Product.create!(name: "Build Your Own Box", slug: "build-your-own-box", available_on: "2017-09-30 16:00:00", dynamic_variants: true, price: 990.00, shipping_category_id: 1, promotionable: true, description2: "Build")

s = Spree::Product.find_by(name:"Build Your Own Box")
s.taxon_ids = [998,999] 
s.save
end
     if Spree::Product.where(name:"E1 - 藍藻").empty?
Spree::Product.create!(name: "E1 - 藍藻", slug: "spirulina", available_on: "2017-09-30 16:00:00", shipping_category_id: 1, dynamic_variants: true, price: 990.00, promotionable: true, description2: "")

s = Spree::Product.find_by(name:"E1 - 藍藻")
s.taxon_ids = [994] 
s.save
end
     if Spree::Product.where(name:"J2 - Test Juice").empty?
Spree::Product.create!(name: "J2 - Test Juice", slug: "j2-test-juice", available_on: "2017-09-30 16:00:00", shipping_category_id: 1, dynamic_variants: true, price: 135.00, promotionable: true, description2: "Juices")

s = Spree::Product.find_by(name:"J2 - Test Juice")
s.taxon_ids = [990] 
s.save
end
     if Spree::Product.where(name:"J1-test-juice").empty?
Spree::Product.create!(name: "J1-test-juice", slug: "test-juice", available_on: "2017-09-30 16:00:00", shipping_category_id: 1, dynamic_variants: true, price: 135.00, promotionable: true, description2: "Juices")

s = Spree::Product.find_by(name:"J1-test-juice")
s.taxon_ids = [990] 
s.save
end
     if Spree::Product.where(name:"Yellow Box").empty?
Spree::Product.create!(name: "Yellow Box", slug: "yellow-box", available_on: "2017-09-30 16:00:00", shipping_category_id: 1, dynamic_variants: true, price: 990.00, promotionable: true, description2: "Yellow Third")

s = Spree::Product.find_by(name:"Yellow Box")
s.taxon_ids = [995, 992, 998] 
s.save
end
     if Spree::Product.where(name:"Red Box").empty?
Spree::Product.create!(name: "Red Box", slug: "red-box", available_on: "2017-09-30 16:00:00", shipping_category_id: 1, dynamic_variants: true, price: 990.00, promotionable: true, description2: "Box First")

s = Spree::Product.find_by(name:"Red Box")
s.taxon_ids = [996, 998, 993] 
s.save
end
     if Spree::Product.where(name:"Green Box").empty?
Spree::Product.create!(name: "Green Box", slug: "green-box", available_on: "2017-09-30 16:00:00", shipping_category_id: 1, dynamic_variants: true, price: 990.00, promotionable: true, description2: "Box Second")

s = Spree::Product.find_by(name:"Green Box")
s.taxon_ids = [998,991,997] 
s.save
end


#### Adding Taiwan as a Shippable Zone  ####

     if Spree::Zone.where(name:"Taiwan").empty?
Spree::Zone.create!(name: "Taiwan", description: "Ship only in Taiwan", default_tax: false, id: 100)
end
  

#### Adding Shipping Methods THIS WILL NEED MORE WORK BUT FOR NOW - Manually enter these in before running the rake ####


     if Spree::ShippingMethod.where(name:"Black Cat").empty?
Spree::ShippingMethod.create!(name: "Black Cat", display_on: "both", tax_category_id: 1,tracking_url: "http://www.t-cat.com.tw/Inquire/Trace.aspx?no=")
end
     
    if Spree::ShippingMethod.where(name:"In Store - 宜蘭市女中路三段117號 Yilan City").empty?
Spree::ShippingMethod.create!(name: "In Store - 宜蘭市女中路三段117號 Yilan City", display_on: "both", admin_name: "instore")
end
#### Adding Payment Methods ####


    if Spree::PaymentMethod.where(name:"信用卡(Allpay 歐付寶)").empty?
Spree::PaymentMethod.create!(name: "信用卡(Allpay 歐付寶)", display_on: "both", description: "credit card", active: true, type: "Spree::Gateway::Allpay")
end

    if Spree::PaymentMethod.where(name:"現金").empty?
Spree::PaymentMethod.create!(name: "現金", display_on: "both", description: "cash", active: true, type: "Spree::Gateway::Check")
end

  
  end

end
