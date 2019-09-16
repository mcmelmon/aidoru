ActiveAdmin.register Performance do
    permit_params :name_english, :name_native, :youtube_video_id
  
    index do
      selectable_column
      id_column
      column :name_native
      column :name_english
      column :youtube_video_id
      column :created_at
      actions
    end
  
    filter :name_native
    filter :name_english
    filter :created_at
  
    form do |f|
      f.inputs do
        f.input :name_native
        f.input :name_english
        f.input :youtube_video_id
      end
      f.actions
    end
  
  end