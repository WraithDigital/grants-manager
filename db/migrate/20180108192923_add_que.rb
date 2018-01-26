class AddQue < ActiveRecord::Migration[4.2]
  def self.up
    Que.migrate! version: 3
  end

  def self.down
    Que.migrate! version: 0
  end
end
