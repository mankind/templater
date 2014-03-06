require 'test_helper'

class SqlTemplateTest < ActiveSupport::TestCase
   test "resolver returns a template with the saved body" do
      resolver = SqlTemplate::Resolver.new
      details = {formats: [:html], locale: [:en], handlers: [:erb]}
      
      # 1)assert resolver can't find the template as the databse is empty
      #find_all(name, prefix, partial, details)
      
     assert resolver.find_all('index', 'posts', false, details).empty?
     
     # 2) create a template in the database
     SqlTemplate.create!(
       body: "<%= 'hi from SqlTemplate! %>",
       path: "posts/index",
       format: "html",
       locale: "en",
       handler: "erb",
       partial: "false"
       )
       
      # 3) assert the template can now be found 
      template = resolver.find_all("index", "posts", false, details).first
      assert_kind_of ActionView::Template, template
      
      #4) Assert specific information about the found template
      assert_equal  "<%= 'hi from SqlTemplate! %>", template.source
      assert_kind_of ActionView::Template::Handlers::Erb, template.handler
      assert_equal, [:html], template.formats
      assert_equal, "posts/index", template.virtual
      assert_match %r[Sqltemplate - \d+ - "posts/index"], template.identifier
  end
   
end
