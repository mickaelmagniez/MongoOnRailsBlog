class Comment
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :title, :type => String
  field :body, :type => String
  field :published_at, :type => DateTime

  embedded_in :article, :inverse_of => :comments
  referenced_in :user, :stored_as => :array, :inverse_of => :comment

  before_create :set_published_date

  def set_published_date
    self.published_at = DateTime.now
  end
end
