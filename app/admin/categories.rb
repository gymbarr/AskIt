ActiveAdmin.register Category do
  # permit_params :email, :username, role_ids: []

  index do
    selectable_column
    id_column
    column :name
    column :questions_count
    column :created_at
    actions
  end
end
