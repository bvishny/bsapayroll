class AddSignatureToWeeks < ActiveRecord::Migration
  def change
    add_column :weeks, :signature_json, :text
    add_column :weeks, :signature_image, :text
  end
end
