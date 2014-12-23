class Task < ActiveRecord::Base
  def self.completed
    where :completed => true
  end

  def self.uncompleted
    where :completed => false
  end
end
