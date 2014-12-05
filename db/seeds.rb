Fabricator(:user) do
  name { Faker::Name.name }
  email { |attrs| Faker::Internet.free_email(attrs[:name]) }
  password { 'password' }
  password_confirmation { |attrs| attrs[:password] }
  confirmed_at { Time.now }
  role { User.roles.values.sample }
end

Fabricator(:authorable_assignment) do
  title { Faker::Lorem.sentence }
end

Fabricator(:authorable_problem) do
  problem_text { Faker::Lorem.paragraph }
end

Fabricator(:assignment) do
end

Fabricator(:problem) do
end

100.times { Fabricate(:user) }

User.roles.each do |key, val|
  Fabricate(
    :user,
    email: key.to_s + '@bluprint.com',
    role: val
  )
end

instructors = User.where(
  role: [User.roles[:instructor], User.roles[:administrator]]
)

instructors.each do |instructor|
  students = Array.new(User.all)

  10.times do
    s = students.sample
    students.delete(s)
    instructor.students << s
  end

  5.times do
    Fabricate(:authorable_assignment, user: instructor)
  end

  10.times do
    Fabricate(:authorable_problem, user: instructor)
  end
end

AuthorableAssignment.all.each do |auth_assign|
  5.times do
    auth_assign.auth_probs << AuthorableProblem.all.sample
  end
end
