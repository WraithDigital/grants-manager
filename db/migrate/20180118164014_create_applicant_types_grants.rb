class CreateApplicantTypesGrants < ActiveRecord::Migration[5.1]
  def change
    create_table :applicant_types_grants do |t|
      t.references :grant,          null: false, foreign_key: true
      t.references :applicant_type, null: false, foreign_key: true
    end
  end
end
