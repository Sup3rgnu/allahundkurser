class AddParticipantsToCourse < ActiveRecord::Migration
  def change
  	add_column :courses, :participants, :integer
  end
end
