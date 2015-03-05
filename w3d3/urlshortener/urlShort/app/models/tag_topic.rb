# == Schema Information
#
# Table name: tag_topics
#
#  id    :integer          not null, primary key
#  topic :string
#

class TagTopic < ActiveRecord::Base
  validates :topic, presence: true, uniqueness: true

  has_many(
    :taggings,
    :class_name => 'Tagging',
    :foreign_key => :topic_id,
    :primary_key => :id
  )

  has_many(
    :tagged_urls,
    :through => :taggings,
    :source => :url
  )

  has_many(
    :taggers,
    :through => :taggings,
    :source => :user
  )

  has_many(
    :visits,
    :through => :tagged_urls,
    :source => :visits
  )

  def self.create_or_return(tag)
    t = find_by_topic(tag)
    return t if t
    create(:topic => tag)
  end

  def self.top_link_for(category = self.pluck(:topic).sample)
    cat = find_by_topic(category)
    cat.visits.group(:short_url).order('COUNT(*) DESC').first.url
  end

  def most_popular_link
    tl = TagTopic.top_link_for(topic)
    return tl.short_url, tl.long_url
  end
end
