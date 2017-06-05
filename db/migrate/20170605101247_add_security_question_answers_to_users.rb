class AddSecurityQuestionAnswersToUsers < ActiveRecord::Migration[5.1]
  def change

     add_column :users, :security_question, :string
     add_column :users, :secutity_answer, :string

  end
end
