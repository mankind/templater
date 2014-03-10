class CustomerMail < ActionMailer::Base
  append_view_path SqlTemplate::Resolver.new
  
  default from: "ed@example.com"
  
  #it send a welcome email to the customer object passed in.
  def welcome(customer)
    
    mail(:to => customer.email, 
    
         :subject => "welcome mate!"
     )
  
  end
  
  def liquid_database_template(customer)
    @tmpl = SqlTemplate.find(5) 
    #@body = @tmpl.body
    mail(:to => customer.render('email' => 'boyjerry27@yahoo.co.uk'),   
         :subject => "welcome mate!",
         :body => @tmpl.render('body' => 'You are great!')
     )
  end
end
