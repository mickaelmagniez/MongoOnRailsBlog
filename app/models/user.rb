class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable
  attr_accessible :name, :email, :password, :password_confirmation
  
  references_many :articles, :as => :array, :inverse_of => :user
  references_many :comments, :as => :array, :inverse_of => :user
end
