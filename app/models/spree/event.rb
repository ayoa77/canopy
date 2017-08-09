module Spree
  class Event < Spree::Base
    has_attached_file :event_photo


validates_attachment_content_type :event_photo, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  end
end
