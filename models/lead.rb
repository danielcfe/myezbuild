require_relative  "config_lead"
class Lead

  include Mongoid::Document
  include Mongoid::Timestamps

  ConfigLead.setup.each {| f | field f[:name], type: f[:type]}

  validates_presence_of :name, :date
  validates :email, 
            :presence => true, 
            :uniqueness => true,
            :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+.)+[a-z]{2,})$/i}

  def self.group_by_created_at
    Lead.where(:created_at.gt => 60.day.ago).order(created_at: "desc").group_by{ |u| u.created_at.strftime("%W") }.map { |k,v| [k,v.count] }
  end

end
