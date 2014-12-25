class Task < ActiveRecord::Base

  validates_presence_of :name
  validates_length_of :name, :minimum => 3, :maximum => 8
  validates_uniqueness_of :name, :case_sensitive=>false
  validate :name_not_in_black_list

  def self.completed
    where :completed => true
  end

  def self.uncompleted
    where :completed => false
  end

  private
  def name_not_in_black_list
    if not name.nil? and name.include? 'puncha'
      errors.add :name, 'should not contain puncha'
    end
  end
end
