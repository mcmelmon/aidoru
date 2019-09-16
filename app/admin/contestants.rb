ActiveAdmin.register Contestant do
    permit_params :name_native, :name_english, :headshot_url, :bodyshot_url, :profile_url, :self_introduction_video_url
  
    index do
      selectable_column
      id_column
      column :name_native
      column :name_english
      column :headshot_url
      column :bodyshot_url
      column :self_introduction_video_url
      column :profile_url
      column :created_at
      actions
    end
  
    filter :name_native
    filter :name_english
    filter :created_at
  
    form do |f|
      f.inputs do
        f.input :profile_url
        f.input :name_native
        f.input :name_english
        f.input :headshot_url
        f.input :bodyshot_url
        f.input :self_introduction_video_url
      end
      f.actions
    end
  
  end