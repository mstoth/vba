class User < ActiveRecord::Base
  has_many :venues
  has_and_belongs_to_many :groups
  
  acts_as_authentic do |c|
    c.logged_in_timeout = 20.minutes # default is 10.minutes
  end
  
  geocoded_by :zip
  after_validation :geocode
  validates_presence_of :zip
  validates_uniqueness_of :login
  validates_presence_of :login
  validates_format_of :zip, :message => "only the 5-digit zip code is needed1", :with => /\A[0-9]{5}\z/
  
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.password_reset_instructions(self).deliver
  end

  def join_group
    id=params[:id]
    g=Group.find(id)
    self.groups << g
  end
    
  # if offer = true, returns non-booked concerts, i.e. offerings. 
  # if offer = false, returns booked concerts. 
  def my_concerts(offer=true)
    groups=self.groups
    @concerts = []
    groups.each do |g|
      g.concerts.each do |c|
        if c.offer==offer
          if c.date >= Date.today
            @concerts << c
          end
        end
      end
    end
    @concerts.sort! { |a,b| a.date <=> b.date }
  end
end
