class CCBatch < ActiveRecord::Base
  attr_protected :created_at
  
  belongs_to :user
  
  def mvd_total
    self.vs_total + self.mc_total + self.dis_total
  end
end
