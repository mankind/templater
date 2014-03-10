class SqlTemplate < ActiveRecord::Base
  #validates :body, :path, presence: true
  validates :format, inclusion: Mime::SET.symbols.map(&:to_s)
  validates :locale, inclusion: I18n.available_locales.map(&:to_s) 
  validates :handler, inclusion: ActionView::Template::Handlers.extensions.map(&:to_s)
  
  class Resolver < ActionView::Resolver
    protected
    
    def find_templates(name, prefix, partial, details)
      conditions = {
        path: normalize_path(name, prefix),
        locale: normalize_array(details[:locale]).first,
        format: normalize_array(details[:formats]).first,
        handler: normalize_array(details[:handlers]).first,
        partial: partial || false
      }
      ::SqlTemplate.where(conditions).map do |record| 
        initialize_template(record)
      end
    end
    
    #normalize name and prefix, so the tuple ["index", "users"] becomes
    # "users/index" and the tuple ["template", nil] becomes template.
    def normalize_path(name, prefix)
      prefix.present? ? "#{prefix}/#{name}" : name
    end
    
    #Normalize arrays by converting all symbols string
    def normalize_array(array)
      array.map(&:to_s)
    end
    
    #Initialize Actionview::Template object based on the record found
    def initialize_template(record)
      source = record.body
      identifier = "SqlTemplate - #{record.id} - #{record.path.inspect}"
      handler = ActionView::Template.registered_template_handler(record.handler)
      
      details = {
        format: Mime[record.format],
        update_at: record.updated_at,
        virtual_path: virtual_path(record.path, record.partial)
      }
      
      ActionView::Template.new(source, identifier, handler, details) 
    end
    
    #make paths as "users/user" becomes "users/_user" for partials.
    def virtual_path(path, partial)
      return path unless partial
      if index = path.rindex("/")
        path.insert(index + 1, "_")
      else
        "_#{path}"
      end  
    end 
    
  end #closes class Resolver
  
  #code for rendering the body filed when the template handler is liquid
  
  
  def to_liquid
    SqlTemplateDrop.new(self)
  end
  
  
   #email contains the lquid markup to render the address to send the email. When updating this attribute, the
  # email_template parses the template and stores the serialized object
  # for quicker rendering.
  
  def body=(text)
    if self[:handler] == 'liquid'
      @template = Liquid::Template.parse(text)
      self[:body] = Marshal.dump(@template) 
        
        #throws unexpected keyword_rescue, expecting keyword_end

      #rescue Liquid::SyntaxError => error
      #@syntax_error = error.message  
 
    end   #closes if 
  end
  
  #renders the email field as liquid markpup template
  def render(options = {})
    template.render options
  end
  
  private
  
  #return  usable template instance
  def template
    return @body unless @body.nil?
    
    #if self[:body].blank?
     # @template = Liquid::Template.parse(body)
      #self[:body] = Marshal.dump(@template)
      #save
    #else
      @body = Marshal.load(self[:body])
    #end
    
    @body
  end
  
   
end
