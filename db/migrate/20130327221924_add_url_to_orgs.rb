class AddUrlToOrgs < ActiveRecord::Migration
  def change
  	add_column :orgs, :url, :string
  end
end
