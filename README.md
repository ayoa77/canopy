# README


This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

populate_prices in product model will allow you to set prices for multiple variants.

 add an auth user ->

<%=@custom.about1%>
<%=@custom.about2%>
<%=@custom.about3%>
<%=@custom.about4%>

<%= image_tag @custom.photo4.url if @custom.photo4.url %>

 rake spree_auth:admin:create

* Database creation

* Database initialization

edit the models in the spree_product_assembly gem to change the order_contents_decorator to us alias_method and switch :parts and :line_item
edit the model decorator for products to change the position of the has_many associations there.

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
Projects/canopy/gems/allPayAIO_Ruby-master/Payment ▶ gem install --local allpay_payment-2.0.8.gem
* ...

Spree::Frontend::Config[:locale] = :en
Spree::Backend::Config[:locale] = "zh-TW"
to set up custom for the first time go to /admin/customnew


---duplicating database entries---
old_type = Spree::Option.find(task_id)
new_task = Task.new(old_task.attributes.merge({:scheduled_on => some_new_date}))

### manually restart passenger
 passenger-config restart-app /var/www/canopy/current
 passenger start -a 0.0.0.0 -p 3000 -d -e production


 sudo apt-get install libpq-dev
 cap production deploy