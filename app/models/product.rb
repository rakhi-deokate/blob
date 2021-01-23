class Product < ApplicationRecord
  require 'csv'

  def self.import(file_path)
    CSV.foreach(file_path, headers: true) do |row|
      product_hash = row.to_hash
      product = Product.where(id: product_hash["id"])

      if product.count == 1
        # Prevent CSV updates from changing the database comments attribute
        product.first.update_attributes(product_hash.expect("comments"))
      else
        Product.create!(product_hash)
      end
    end
  end

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      where(nil)
    end
  end

end
