class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.integer :job_id
      t.integer :service_provider_id
      t.integer :price
      t.boolean :request_meeting, :default => false
      t.string :message
      t.integer :status
      t.timestamps
    end
  end
end
