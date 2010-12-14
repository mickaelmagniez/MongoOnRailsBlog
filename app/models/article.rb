class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :slug, :type => String
  field :title, :type => String
  field :body, :type => String
  field :published_at, :type => DateTime
  field :edited_at, :type => DateTime
  field :tags, :type => Array
  
  referenced_in :user, :stored_as => :array, :inverse_of => :articles
  embeds_many :comments

  key :slug

  before_save :set_edited_date
  before_create :set_slug,:set_published_date
  
  def set_published_date
    self.published_at = DateTime.now
  end
  
  def set_edited_date
    self.edited_at = DateTime.now
  end

  def set_slug
    self.slug = "#{title.parameterize}"
  end

  def self.tag_cloud
    map = <<EOF
      function() {
        for (index in this.tags) {
          emit(this.tags[index],1);
        }
      }
EOF
    reduce = <<EOF
      function(previous, current) {
        var count = 0;
        for (index in current) {
          count += current[index]
        }
        return count;
      }
EOF
    if Mongoid.master.collection(collection.name).count != 0
      collection.map_reduce(map,reduce).find()
    else
      []
    end
      
  end

  validates_presence_of :title, :body
  validates_uniqueness_of :slug

  index [[:published_date, Mongo::DESCENDING]]
  index :tags
  index :user

end
