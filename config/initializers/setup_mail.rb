ActionMailer::Base.delivery_method = :smtp

=begin
ActionMailer::Base.smtp_settings = {
    :address => ENV["mandrill_test_host"],
    #ports 25 and 2525 are also supported by mandrillwith STARTTLS
    :port => ENV["mandrill_test_port"],
    :enable_starttls_auto => true, # detects and uses STARTTLS
    :user_name => ENV["mandrill_test_username"],
    # SMTP password is any valid mandrill API key
    :password => ENV["mandrill_test_password"],
    # Mandrill supports 'plain' or 'login'
    :authentication => 'login', 
    #your domain to identify your server when connecting
    :domain => 'localhost:3000'
  }
=end

ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => 587,
    :enable_starttls_auto => true, 
    :user_name => "",
    :password => "",
    :authentication => 'plain', 
    :domain => 'localhost:3000'
  }

