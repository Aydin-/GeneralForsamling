class Company < ActiveRecord::Base
#	if action= :edit do
	validates :email, length: {:on => :update, minimum: 5} 
	validates :contact_name, length: {:on => :update, minimum: 5 }
#end
end
