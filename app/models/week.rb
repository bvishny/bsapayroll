class Week < ActiveRecord::Base
  # Protected Attributes
  attr_protected :user_id
  attr_protected :begins
  attr_protected :ends
  attr_protected :approved
  attr_protected :hourly_rate
  
  # Relations
  belongs_to :user
  
  # Validations
  validate :check_total_hours
  
  # Scopes
  default_scope :order => 'created_at DESC'
  scope :approved, where(:approved => 1)
  scope :current, (lambda do |weeks_ago = 0|
     self.where('begins >= ? and ends <= ?', Week.begins(weeks_ago), Week.ends(weeks_ago))
  end)
  
  # InstanceMethods
  def hours
    (0..6).inject(0.0) { |sum, entry| sum + self["day_#{entry}"] }
  end
  
  def wages
    self.hours * self.hourly_rate
  end
  
  # Class Methods
  # For the current week
  def self.begins(weeks_ago = 0)
    Time.zone = "Eastern Time (US & Canada)"
    time = Time.zone.now
    weeks_ago += 1 if time.wday.zero?
    Time.at((time.to_i - (time.sec + (60 * time.min) + (3600 * time.hour) + ((24 * 3600) * time.wday))) - (weeks_ago * (3600 * 24 * 7))).to_date
  end
  
  def self.ends(weeks_ago = 0)
    Time.at(Week.begins(weeks_ago).to_time.to_i + (1 * 3600 * 24 * 6)).to_date
  end
  
  def self.log(user, weeks_ago = 0)
    week = Week.new
    unless user.weeks.where(:begins => (start = Week.begins(weeks_ago)), :ends => (ending = Week.ends(weeks_ago))).present?
      {:user => user, :hourly_rate => user.hourly_rate, :begins => start, :ends => ending}.each { |key, value| week.send("#{key}=", value) }
      week.save!
    end
    week
  end
  
  def self.timesheet_for(user, weeks_ago = 0)
    ((sheet = user.weeks.current(weeks_ago)).empty?) ? (Week.log(user, weeks_ago)) : (sheet[0])
  end

  private
  def check_total_hours
     self.errors[:day_6] << "Total hours from Sunday to Saturday cannot exceed 40 hours!" if self.hours > 40
     self.errors[:day_6] << "You can't submit a negative number of hours!" if self.hours < 0.0
  end
end
