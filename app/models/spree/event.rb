module Spree
  class Event < Spree::Base
    has_attached_file :event_photo,
    styles: { mini: '48x48>', small: '100x100>', product: '240x240>', large: '600x600>' }



validates_attachment_content_type :event_photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  end
end
