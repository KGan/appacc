# == Schema Information
#
# Table name: visits
#
#  id         :integer          not null, primary key
#  visitor_id :integer
#  url_id     :integer
#

class Visit < ActiveRecord::Base
  validates :visitor_id, presence: true
  validates :url_id, presence: true

  belongs_to(
    :visitor,
    :class_name => 'User',
    :foreign_key => :visitor_id,
    :primary_key => :id
  )

  belongs_to(
    :url,
    :class_name => 'ShortenedUrl',
    :foreign_key => :url_id,
    :primary_key => :id
  )

  def self.record_visit!(user, shortened_url)
    short = ShortenedUrl.find_by_short_url(shortened_url)
    if short
      Visit.create!(:visitor_id => user.id,
                    :url_id => short.id)
    end
  end
end
