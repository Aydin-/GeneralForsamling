class Company < ActiveRecord::Base
#	if action= :edit do
	validates :email, length: {:on => :update, minimum: 5} 
	validates :contact_name, length: {:on => :update, minimum: 2 }
	validates :company_name, length: {:on => :update, minimum: 2 }
	validates :time, length: {:on => :update, minimum: 2 }
	validates :address, length: {:on => :update, minimum: 2 }
#end
end
