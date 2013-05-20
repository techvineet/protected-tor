module ApplicationHelper
  
  def link_to_remove_fields(f)
    f.hidden_field(:_destroy) + '<a class="close pull-left" onclick="remove_fields(this);" href="javascript:void(0)">&times;</a>'.html_safe
  end
  
  def link_to_add_fields(f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder, :first => false)
    end
    #link_to_function(name, )")
    "<button type='button' class='btn btn-mini btn-success' onclick='add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")'>Add More</button>".html_safe
  end
  
end
