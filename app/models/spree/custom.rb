module Spree
  class Custom < Spree::Base
    has_attached_file :photo1
    has_attached_file :photo2
    has_attached_file :photo3
    has_attached_file :photo4
    has_attached_file :photo5
    has_attached_file :photo6
    has_attached_file :photo7
    has_attached_file :photo8

      validates_attachment_content_type(
        :photo1,
        :photo2,
        :photo3,
        :photo4,
        :photo5,
        :photo6,
        :photo7,
        :photo8,
        :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
        )
  end
end
