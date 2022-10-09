ActiveAdmin.register Category do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    column :questions_count
    column :created_at
    actions
  end

  filter :name
  filter :questions_count
  filter :created_at

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :questions_count
      row :created_at
      row :updated_at
    end
  end
end
