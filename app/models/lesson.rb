class Lesson < ActiveRecord::Base

  belongs_to :section
  has_one :course, :through => :section
  has_many :lesson_completions, :dependent => :destroy
  has_many :completing_users, :through => :lesson_completions, :source => :student

  validates_uniqueness_of :position, :message => "Lesson position has already been taken"

  def next_lesson
    lessons = self.course.lessons.order("position asc")
    if self.position >= lessons.first.position + lessons.size - 1
      return nil
    else
      return lessons.find_by_position(self.position + 1)
    end
  end

  def prev_lesson
    lessons = self.course.lessons.order("position asc")
    if self.position <= 1
      return nil
    else
      return lessons.find_by_position(self.position - 1)
    end
  end

  def completed_students_count
    self.lesson_completions.count
  end

  def current_students_count
    #to do
  end
end
