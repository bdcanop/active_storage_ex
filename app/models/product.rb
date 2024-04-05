class Product < ApplicationRecord
  has_many_attached :pictures, service: :azure
end
