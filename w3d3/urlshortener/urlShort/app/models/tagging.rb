# == Schema Information
#
# Table name: taggings
#
#  id        :integer          not null, primary key
#  topic_id  :integer
#  tagger_id :integer
#  url_id    :integer
#

class Tagging < ActiveRecord::Base

  belongs_to(
    :url,
    :class_name => 'ShortenedUrl',
    :foreign_key => :url_id,
    :primary_key => :id
  )

  belongs_to(
    :topic,
    :class_name => 'TagTopic',
    :foreign_key => :topic_id,
    :primary_key => :id
  )

  belongs_to(
    :user,
    :class_name => 'User',
    :foreign_key => :tagger_id,
    :primary_key => :id
  )

  def self.tag_url(user, url, tag_string)
    tag = TagTopic.create_or_return(tag_string)
    create(:tagger_id => user.id, :url_id => url.id, :topic_id => tag.id)
  end

end
