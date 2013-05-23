class AddContactNumberToServiceProvider < ActiveRecord::Migration
  def change
    add_column :service_provider_details, :contact_number, :string
  end
end
