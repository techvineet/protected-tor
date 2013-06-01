categories = {
  "Business Services" => [
    "Accounting",
    "HR / Payroll",
    "Financial Services & Planning"
  ],
  "Administrative Support" => [
    "Data Entry",
    "Personal Assistant"
  ]
}


categories.each do |category, subcategories|
  category = Category.find_or_create_by_name(category)
  subcategories.each do |subcategory|
    unless category.children.exists?(:name => subcategory)
      category.children.create :name => subcategory
    end
  end
end