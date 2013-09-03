json.array!(@companies) do |company|
  json.extract! company, :email, :company_name, :contact_name, :date, :time, :address
  json.url company_url(company, format: :json)
end