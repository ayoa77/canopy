module Spree
  class Custom < Spree::Base
    has_attached_file :photo1,
        styles: { product: '240x240>', large: '600x600>' }

    has_attached_file :photo2,
        styles: { product: '240x240>', large: '600x600>' }

    has_attached_file :photo3,
        styles: { product: '240x240>', large: '600x600>' }

    has_attached_file :photo4,
        styles: { product: '240x240>', large: '600x600>' }

    has_attached_file :photo5,
        styles: { product: '240x240>', large: '600x600>' }

    has_attached_file :photo6,
        styles: { product: '240x240>', large: '600x600>' }

    has_attached_file :photo7,
        styles: { product: '240x240>', large: '600x600>' }

    has_attached_file :photo8,
        styles: { product: '240x240>', large: '600x600>' }


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
