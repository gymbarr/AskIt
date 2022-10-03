ActiveAdmin.register User do
  permit_params :email, :username, role_ids: []

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :roles
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :username
  filter :roles
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :email
      f.input :username
      f.input :roles
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :username
      row :roles
      row :reset_password_token
      row :reset_password_sent_at
      row :remember_created_at
      row :created_at
      row :updated_at
      row :locale
    end
  end
end
