<% module_namespacing do -%>
class <%= class_name %> 
  attr_accessor :message
  
  def initializer(message)
    @message = message
  end
  
end
<% end -%>