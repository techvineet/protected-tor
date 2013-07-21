class AddServiceProviderIdToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :service_provider_id, :integer
  end
end
