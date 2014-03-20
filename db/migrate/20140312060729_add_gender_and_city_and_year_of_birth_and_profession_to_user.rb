class AddGenderAndCityAndYearOfBirthAndProfessionToUser < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string
    add_column :users, :city, :string
    add_column :users, :year_of_birth, :date
    add_column :users, :profession, :string
  end
end
