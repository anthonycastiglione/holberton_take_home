class AddReturnedDateToLoan < ActiveRecord::Migration[6.0]
  def change
    remove_column :loans, :returned, :boolean, null: false, default: false
    add_column :loans, :returned_date, :datetime
  end
end
