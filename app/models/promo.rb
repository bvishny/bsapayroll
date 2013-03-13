class Promo < ActiveRecord::Base
  attr_accessible :amount, :available, :code, :expires
end
