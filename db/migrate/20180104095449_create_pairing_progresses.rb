class CreatePairingProgresses < ActiveRecord::Migration[5.1]
  def change
    create_table :pairing_progresses do |t|
      t.integer :current_students_order, array: true, default: []
      t.integer :current_iteration, default: 0

      t.timestamps
    end
  end
end
