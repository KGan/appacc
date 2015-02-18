# Students and Courses
#
# Write a set of classes to model Students and Courses.
#
# Student#initialize should take a first and last name.
# Student#name should return the concatenation of the student's first and last name.
# Student#courses should return a list of the Courses in which the student is enrolled.
# Student#enroll should take a Course object, add it to the student's list of courses, and update the Course's list of enrolled students.
# enroll should ignore attempts to re-enroll a student.
# Student#course_load should return a hash of departments to # of credits the student is taking in that department.
# Course#initialize should take the course name, department, and number of credits.
# Course#students should return a list of the enrolled students.
# Course#add_student should add a student to the class.
# Probably can rely upon Student#enroll.
# And some extras:
#
# Each course should also take a set of days of the week (:mon, :tue, ...), plus a time block (assume each day is broken into 8 consecutive time blocks). So a course could meet [:mon, :wed, :fri] during block #1.
# Update your #initialize method to also take a time block and days of the week.
# Write a method Course#conflicts_with? which takes a second Course and returns true if they conflict.
# Update Student#enroll so that you raise an error if a Student enrolls in a new course that conflicts with an existing course time.
# May want to write a Student#has_conflict? method to help.
class Course
  def initialize(name, department, credits, days_of_week, block)
    @name = name
    @department = department
    @credits = credits
    @students = []
    @days_of_week = days_of_week
    @block = block
  end

  def students
    @students.map { |student| student.name }
  end

  def add_student(student)
    raise "Course Conflict!" if student.has_conflict?(self)
    if !@students.include?(student)
      @students.push(student)
      student.join_course(self)
    end
  end

  attr_reader :days_of_week, :block, :department, :credits

  def conflicts_with(course)
    days_conflict = !(self.days_of_week & course.days_of_week).empty?
    sameblock = self.block == course.block
    days_conflict && sameblock
  end
end

class Student
  def initialize(first_name,last_name)
    @name = "#{first_name} #{last_name}"
    @courses = []
  end

  def name
    @name
  end

  def courses
    @courses
  end

  def enroll(course)
    course.add_student(self)
  end

  def join_course(course)
    @courses.push(course)
  end

  def has_conflict?(course)
    !@courses.select { |enrolled_course|
      enrolled_course.conflicts_with(course) }.empty?
  end

  def course_load
    by_department = @courses.group_by { |course| course.department }
    by_department.each do |department, courses|
      by_department[department] = courses.inject(0) { |acc, course| acc + course.credits }
    end
  end
end
