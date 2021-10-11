#student.rb
class Student < ApplicationRecord
  # class method written using a scope (https://www.rubyguides.com/2019/10/scopes-in-ruby-on-rails/)
  scope :by_name, ->(name) { where("first_name LIKE ? OR last_name LIKE ?", "%#{name}%", "%#{name}%") }
  
  # class method written without using a scope
  # def self.by_name(name)
  #   Student.where("first_name LIKE ? OR last_name LIKE ?", "%#{name}%", "%#{name}%")
  # end

  def to_s
    "#{first_name} #{last_name}"
  end
end

#------------------------------------------------------------------
# students_controller.rb
class StudentsController < ApplicationController
  def index
    students = if params[:name]
                 Student.by_name(params[:name])
               else
                 Student.all
               end    
    render json: students
  end

  def show
    student = Student.find_by(id: params[:id])
    render json: student
  end
end

