class User < ActiveRecord::Base
  acts_as_authentic
  has_many :collections, :class_name => "Collection", :foreign_key => "user_id"
  #attr_accessor :password, :password_confirmation
  
  def self.create_admin
    admin = User.find_by_login('admin')
    admin = User.create({:email => 'admin@mrs.com', :login => 'admin', :password =>'password', 
          :password_confirmation => 'password' }) if admin.nil?
    admin
  end
  
  def self.get_collection_for_admin
    admin = User.create_admin
    collection = admin.collections.try(:first) 
    collection = Collection.create!({ :name => 'Admin Collection', :user => admin }) if collection.blank?
    collection
  end
  
end
