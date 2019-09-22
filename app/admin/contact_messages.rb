ActiveAdmin.register ContactMessage do
    permit_params :email, :message

    index do
        selectable_column
        id_column
        column :email
        column :message
        actions
    end

    filter :email
    filter :message

    show do
        attributes_table do
            row :email
            row :message
        end
    end

    form do |f|
        f.inputs do
            f.input :email
            f.input :message
        end
        f.actions
    end
end