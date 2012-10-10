require 'rubygems'
require 'bundler'
Bundler.require(:default)

class User
    include DataMapper::Resource
    include Paperclip::Resource

    property :id,         Serial
    property :name,       String,  :unique => true, :length => 3..50, :required => true 
    property :password,    BCryptHash,   :required => true 
    property :email,       String, :format => :email_address, :length => 6..50,   :required => true 
    property :secret, String
    property :created_at, DateTime
    property :updated_at, DateTime
    has_attached_file :resume,
        :url => "/system/:attachment/:id/:style/:basename.:extension",
        :path => "#{APP_ROOT}/public/system/:attachment/:id/:style/:basename.:extension"

    def to_json(params = {})
        rep = {
            :id => self.id,
            :name => self.name,
            :email => self.email
        }
        if self.resume.file?
            rep[:resume] = self.resume.url
        end
        JSON.generate(rep)
    end

    def to_json_private(params={})
        JSON.generate({
            :id => self.id,
            :name => self.name,
            :email => self.email,
            :secret => self.secret
        })
    end
end

