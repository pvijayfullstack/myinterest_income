# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  #calling helper to pass to javascript inline which the javascript function will replace with regular expression
  #just to add a new investment.
  #This gets executed making use of partials but can be directly still called from Javascript
  #the new_object in this case is investment. Could rather be created later also.

  #Alternative, let JavaScript call without inline. And show up values directly similar to above.

  # In the end, the params[:customer] should be something like
  #"name"=>"cust1", "investments_attributes"=>{"1626"=>{"investment_amount"=>"273", "investment_name"=>"inv1", "investment_apy"=>"8"}, "1627"=>{"investment_amount"=>"818", "investment_name"=>"inv2", "investment_apy"=>"9"}}
  #here 1626 and 1627 are just dummy
  #Under investigation the approaches here.
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :inv_f => builder)
    end
    link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
  end
end
