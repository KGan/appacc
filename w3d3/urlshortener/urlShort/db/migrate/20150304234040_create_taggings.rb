class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :topic_id
      t.integer :tagger_id
      t.integer :url_id
    end

    add_index :taggings, [:topic_id, :tagger_id, :url_id] , unique: true
  end
end
