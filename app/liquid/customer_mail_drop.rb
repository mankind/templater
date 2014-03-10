class CustomerMailDrop < Liquid::Drop
  def initialize(klass)
    #@klass = CustomerMailer.find(params[:id])
    @klass = klass
  end
  
  def email
    #@klass.email
    @klass["email"]
  end
end
