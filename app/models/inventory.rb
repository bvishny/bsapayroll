class Inventory < ActiveRecord::Base
  # Relations
  belongs_to :product
  belongs_to :user
  belongs_to :ar

  # Scopes
  scope :shipment, where(:action => 'SHIPMENT')
  scope :sale, where(:action => 'SALE')
  scope :trash, where(:action => 'TRASH')
  scope :return, where(:action => 'RETURN')
  scope :move, where(:action => 'MOVE')
  scope :void, where(:action => 'VOID')


  # Locations
  def self.Locations
  	["345", "DESK", "LAUNDRY"]
  end

  # Get Inventory
  def self.inventory_for(product, size)
  	Inventory.where(:product_id => product.id, :size => size, 
  		:action => ["SHIPMENT", "SALE", "TRASH", "RETURN"]).select([:quantity, :avg_cost]).inject({}) { |hash, inv|
  		((hash[inv.avg_cost]) ? (hash[:avg_cost] += inv.quantity) : (hash[inv.avg_cost] = inv.quantity))
  		hash
  	}
  end

  def self.costs_for(product, size, qty)
  	costs = self.inventory_for(product, size).select { |x| x[1] >= 0 }.sort { |a,b| a[0].to_f <=> b[0].to_f }.map { |k, v| 
  		[k, (q = [v, qty].min)]; qty -= q 
  	} 
  	(qty.zero?) ? costs : (costs << [product.price, qty])
  end

  # Recording Actions
  def self.record_shipment(product, size, qty, user, cost, loc, comments="")
  	create({:product => product, :size => size, :quantity => qty, :location => loc,
  		:action => "SHIPMENT", :user => user, :avg_cost => cost.to_f / qty, :sale_price => 0.0,
  		:profit => 0.0, :discount => 0.0, :total => -1 * cost, :comments => comments})
  end

  def self.record_sale(ar, product, size, qty, user, loc, code="", comments="")
  	costs_for(product, size, qty).each { |avg_cost, q|
  		create({:product => product, :size => size, :quantity => -1 * q, :location => loc,
  			:action => "SALE", :user => user, :avg_cost => avg_cost, :discount => (ds = product.apply_discount(code)),
  			:sale_price => (sp = product.price - ds),
  			:profit => sp - avg_cost, :total => sp * q, :ar_id => ar.id, :comments => comments})
  	}
  end

  def record_trash(product, size, qty, user, loc, comments="")
  	costs_for(product, size, qty).each { |avg_cost, q|
  		create({:product => product, :size => size, :quantity => -1 * q, :location => loc,
  			:action => "TRASH", :user => user, :avg_cost => avg_cost, :total => -1 * avg_cost * q, 
  			:comments => comments})
  	}
  end

  def self.record_return(ar, product, size, qty, user, loc, code="", comments="") # If a refund amt is specified, it is a refund. Otherwise an exchange
    costs_for(product, size, qty).each { |avg_cost, q|
      create({:product => product, :size => size, :quantity => q, :location => loc,
        :action => "RETURN", :user => user, :avg_cost => avg_cost, :discount => 0.0,
        :sale_price => -1 * (sp = ar.amount),
        :profit => -1 * (sp - avg_cost), :total => -1 * sp * q, :ar_id => ar.id, :comments => comments})
    }
  end

  def record_move(product, size, qty, user, loc, loc2, comments = "")
    costs_for(product, size, qty).each { |avg_cost, q|
      create({:product => product, :size => size, :quantity => -1 * q, :location => loc,
        :action => "MOVE", :user => user, :avg_cost => avg_cost, :discount => 0.0,
        :sale_price => 0.0,
        :profit => 0.0, :total => -1 * sp * q, :comments => comments})

      create({:product => product, :size => size, :quantity => q, :location => loc2,
        :action => "MOVE", :user => user, :avg_cost => avg_cost, :discount => 0.0,
        :sale_price => 0.0,
        :profit => 0.0, :total => sp * q, :comments => comments})
    }
  end

end
