json.array!(@customer_mailers) do |customer_mailer|
  json.extract! customer_mailer, :id, :name, :email
  json.url customer_mailer_url(customer_mailer, format: :json)
end
