ActiveAdmin.register Contest do
  permit_params :end_date, :group_size, :name_english, :name_native, :start_date, :url

  index do
    selectable_column
    id_column
    column :name_native
    column :name_english
    column :url
    column :start_date
    column :end_date
    column :created_at
    actions
  end

  filter :name_native
  filter :name_english
  filter :start_date
  filter :end_date
  filter :url
  filter :created_at

  show do
    attributes_table do
      row :name_native
      row :name_english
      table_for contest.most_liked_contestants.map(&:contestant_id) do
        column "Most Liked Contestants" do |contestant_id|
          Contestant.find_by(id: contestant_id).name_english
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name_native
      f.input :name_english
      f.input :url
      f.input :start_date
      f.input :end_date
      f.input :group_size
    end
    f.actions
  end
end