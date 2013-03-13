class Product < ActiveRecord::Base
  attr_accessible :active, :name, :picture_uri, :price, :string

  # Discount Options
  serialize :discount_options

  # Relations
  has_many :inventories

  # Scopes
  scope :active, where(:active => true)

  # Methods
  def toggle!
  	self.update_attributes({:active => (!self.active)})
  end

  def use_discount(code)
  	(p = Promo.where(:code => code).first).update_attributes({:available => p.available - 1})
  end

  def self.discounts
  	Promo.find(:all, :conditions => ["expires > ? and available > 0", Time.now])
  end

  def apply_discount(code)
  	code = code.downcase
  	(not (dsc = discounts.where(:code => code)).first.blank?) ? (use_discount(code); -1 * dsc.amount) : 0.0
  end

end
