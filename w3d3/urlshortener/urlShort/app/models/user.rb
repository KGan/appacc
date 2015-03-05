# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_many(
    :submitted_urls,
    :class_name => 'ShortenedUrl',
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :visitor_id,
    primary_key: :id
  )

  has_many(
    :visited_urls,
    :through => :visits,
    :source => :url
  )

  has_many(
    :dist_visited_urls,
    -> {distinct},
    :through => :visits,
    :source => :url
  )

  def self.create_or_return(email)
    user=find_by_email(email)
    return user if user
    user=create(:email => email)
  end
end
