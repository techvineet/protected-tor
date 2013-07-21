class AddPostedAtToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :posted_at, :datetime
    Job.reset_column_information
    Job.where(:status => POSTED).each do |job|
      job.update_attribute(:posted_at, job.updated_at)
    end
  end
end
