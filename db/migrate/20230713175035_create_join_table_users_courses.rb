class CreateJoinTableUsersCourses < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :courses do |t|
      t.index %i[user_id course_id]
      t.index %i[course_id user_id]
    end
  end
end
