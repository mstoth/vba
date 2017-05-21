class Concert < ActiveRecord::Base
  geocoded_by :zip
  after_validation :geocode
  validates_presence_of :zip, :webpage, :title, :genre
  validates_format_of :webpage,
  :message => "must be a valid URL",
  :with => /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\z/ix
  validates_format_of :zip,
  :message => "only the 5-digit zip code is needed",
  :with => /\A[0-9]{5}\z/

  def address 
    venue = Venue.find(self.venue_id)
    return venue.name + ", " + venue.street1 + " " + venue.city + ", " + venue.state + " " + venue.zip
  end
  
end
