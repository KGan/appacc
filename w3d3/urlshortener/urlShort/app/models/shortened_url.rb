# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string
#  short_url    :string
#  submitter_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true, length: { maximum: 1024 }
  validates :submitter_id, presence: true
  validate :submitter_limits

  belongs_to(
    :submitter,
    class_name: 'User',
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    :through => :visits,
    :source => :visitor
  )

  has_many(
    :distinct_visitors,
    -> {distinct},
    :through => :visits,
    :source => :visitor
  )

  has_many(
    :taggings,
    class_name: 'Tagging',
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :tags,
    :through => :taggings,
    :source => :topic
  )


  def self.random_code
    code = SecureRandom.urlsafe_base64
    while find_by_short_url(code)
      code = SecureRandom.urlsafe_base64
    end

    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(:short_url => random_code, :long_url => long_url, :submitter_id => user.id)
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    distinct_visitors.count
  end

  def num_recent_uniques
    visitors.select(:user_id).where('created_at < ?', 10.minutes.ago).distinct.count
  end

  private
  def submitter_limits
    if ShortenedUrl.where(:submitter_id => submitter_id).where('created_at > ?', 1.minutes.ago).distinct.count > 5
      errors[:submit_count] << "can't be greater than 5 per minute"
    end
  end
end
