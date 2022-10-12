class User < ApplicationRecord
  has_many :todos, dependent: :destroy
end

# one - one
#
# Student
# ID Card - student_id
#
# class Student < ApplicationRecord
#   has_one :id_card
# end
#
# class IdCard < ApplicationRecord
#   belongs_to :student
# end
