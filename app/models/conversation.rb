class Conversation < ApplicationRecord
	 belongs_to :user
     belongs_to :exchange, :class_name => "User"

     has_many :messages, :dependent => :destroy

     
end
