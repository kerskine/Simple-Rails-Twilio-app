class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :SmsMessageSid
      t.string :AccountSid
      t.string :Body
      t.string :From
      t.string :To

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
