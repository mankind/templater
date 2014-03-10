class SqlTemplateDrop < Liquid::Drop
   def initialize(klass)
     @klass = klass
   end
   
   def body
     @klass["body"]
   end
end
