require 'rubygems'
require 'bundler'
Bundler.require(:default)

class Post
    include DataMapper::Resource

    property :id,         Serial
    property :title,       String,  :unique => true, :length => 3..50, :required => true 
    property :text,       Text
    property :created_at, DateTime
    property :updated_at, DateTime

    belongs_to :user

    def to_json(params = {})
        JSON.generate({
            :id => self.id,
            :title => self.title,
            :text => self.text,
            :user => self.user
        })
    end
end

