class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  
  enum role: [:student, :instructor, :administrator]
  
  has_many :assignments
  has_and_belongs_to_many :students,
    join_table: :instructors_students,
    foreign_key: :instructor_id,
    association_foreign_key: :student_id
end
