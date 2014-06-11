class AddAgeAndGenderToUser < ActiveRecord::Migration
  def change
        add_column :users, :dob, :date
        add_column :users, :age, :integer
        add_column :users, :gender, :string
  end
end
