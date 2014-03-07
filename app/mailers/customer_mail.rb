class CustomerMail < ActionMailer::Base
  append_view_path SqlTemplate::Resolver.new
  
  default from: "ed@example.com
  
  #it send a welcome email to the customer object passed in.
  def welcome(customer)
    
    mail(:to => customer.email, 
    
         :subject => "welcome mate!"
     )
  
  end
  
  def liquid_database_template(customer)
    
    mail(:to => customer.email, 
    
         :subject => "welcome mate!"
     )
  end
end
