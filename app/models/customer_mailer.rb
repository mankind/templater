class CustomerMailer < ActiveRecord::Base

  
  def to_liquid
    CustomerMailDrop.new(self)
  end
  
  
   #email contains the lquid markup to render the address to send the email. When updating this attribute, the
  # email_template parses the template and stores the serialized object
  # for quicker rendering.
  
  def email=(text)
    @template = Liquid::Template.parse(text)
    self[:email] = Marshal.dump(@template)
    
    rescue Liquid::SyntaxError => error
      @syntax_error = error.message  
       
  end
  
  #renders the email field as liquid markpup template
  def render(options = {})
    template.render options
  end
  
  private
  
  #return  usable template instance
  def template
    return @email unless @email.nil?
    
    #if self[:email].blank?
      #@template = Liquid::Template.parse(email)
      #self[:email] = Marshal.dump(@template)
     # save
    #else
      @email = Marshal.load(self[:email])
    #end
    
    #@email
  end
  
end #closes Class
