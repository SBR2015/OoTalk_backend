# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

# course data
course_csv = CSV.readlines('db/data/course.csv')
course_csv.shift #1行目は飛ばす
course_csv.each do |row|
  course = Course.new
  course.title = row[0]
  course.level = row[1]
  course.save!
end

# lesson data
lesson_csv = CSV.readlines('db/data/lesson.csv')
lesson_csv.shift #1行目は飛ばす
lesson_csv.each do |row|
  lesson = Lesson.new
  lesson.title = row[0]
  lesson.body = row[1]
  lesson.course_id = row[2]
  lesson.order = row[3]
  lesson.save!
end
<<<<<<< HEAD

=======
>>>>>>> f58e75bd1eaa44e16459ed4cbfacb114c0abedb6
