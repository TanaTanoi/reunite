class Plan < ApplicationRecord
  has_many :plans_users, class_name: PlansUsers
  has_many :users, through: :plans_users
  
  has_many :drills

  has_many :meet_locations
  has_many :start_locations

  def lat
    x= nil
    if(start_locations.count + meet_locations.count > 0)
    x = [start_locations.last, meet_locations.last].compact.sort { |x,y|  y.created_at <=> x.created_at }.first
    end

    if(x.nil?)
      -41.3
    else
      x.lat
    end
  end

  def long
    x= nil
    if(start_locations.count + meet_locations.count > 0)
      x = [start_locations.last, meet_locations.last].compact.sort { |x,y|  x.created_at <=> y.created_at }.first
    end
    if(x.nil?)
      174.7
    else
      x.long || 0
    end
  end
end
