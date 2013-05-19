class CreateServiceProviderDetails < ActiveRecord::Migration
  def change
    create_table :service_provider_details do |t|
      t.integer :user_id
      t.string :company_name
      t.boolean :insurance
      t.string :insurance_amount

      t.timestamps
    end
  end
end
