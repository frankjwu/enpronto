class Task < ActiveRecord::Base
  attr_accessible :complete, :due_date, :name, :priority, :user_id
  
  belongs_to :user
  
  PRIORITY_TYPES = ["Low", "Medium", "High"]
  
  validates :name, :due_date, :priority, :user_id, presence: true
  validates :name, length: {:maximum => 75}
  validates :priority, :inclusion => PRIORITY_TYPES
  validate :date_after_today, :on => :create
  
  def date_after_today
    if (self.due_date - Time.now).to_i < 0
      self.errors.add(:due_date, "must be in the future")
    end
  end
  
  def interval
    return (self.due_date - self.created_at).to_i
  end
  
  def percent
    z = Time.zone.now - self.created_at
    return (z/self.interval)*100
  end
  
  def bar_color
    if self.percent <= 40
      return "success"
    elsif self.percent >= 70
      return "danger"
    else
      return "warning"
    end
  end
end
