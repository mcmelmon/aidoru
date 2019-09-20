ActiveAdmin.register Contestant do
    permit_params :bodyshot_url, :contest_id, :headshot_url, :name_native, :name_english, :profile_url,
                  performances_attributes: [ :id, :name_english, :name_native, :youtube_video_id, :_destroy ]
  
    index do
      selectable_column
      id_column
      column "Contest" do |contestant|
        contestant.contest&.name_english
      end
      column :name_native
      column :name_english
      column :headshot_url
      column :bodyshot_url
      column :profile_url
      column "Adds" do |contestant|
        contestant.contestant_adds&.count
      end
      column "Removes" do |contestant|
        contestant.contestant_removes&.count
      end
      column :created_at
      actions
    end
  
    filter :name_native
    filter :name_english
    filter :created_at

    show do
      attributes_table do
        row "Contest" do
          contestant.contest&.name_english
        end
        row :name_native
        row :name_english
        row :headshot_url
        row :bodyshot_url
        row :profile_url
        table_for contestant.performances.order('created_at') do
          column "Performances" do |performance|
            link_to performance.name_english, [:admin, performance]
          end
        end
      end
    end
  
    form do |f|
      f.inputs do
        f.input :contest_id, as: :select, collection: Contest.all.map{|c| [c.name_english, c.id]}
        f.input :profile_url
        f.input :name_native
        f.input :name_english
        f.input :headshot_url
        f.input :bodyshot_url
        f.has_many :performances, allow_destroy: true do |c|
          c.input :youtube_video_id
          c.input :name_native
          c.input :name_english
        end
      end
      f.actions
    end
  
  end