module Spree
  class Custom < Spree::Base
    has_attached_file :photo1
    has_attached_file :photo2
    has_attached_file :photo3
    has_attached_file :photo4

      validates_attachment_content_type(
        :photo1,
        :photo2,
        :photo3,
        :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
        )
  end
end
