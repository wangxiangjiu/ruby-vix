class CreateVixes < ActiveRecord::Migration
  def change
    create_table :vixes do |t|
      t.float :dte
      t.float :otm
      t.float :fvmean
      t.float :ret
      t.float :vix

      t.timestamps null: false
    end
  end
end
