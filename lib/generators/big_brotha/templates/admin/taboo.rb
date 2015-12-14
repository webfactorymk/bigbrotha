
ActiveAdmin.register BigBrotha::Taboo, as: 'Taboo' do

  menu :parent => "Taboos", :priority => 0
  permit_params :keyword

  filter :keyword
  filter :created_at

  #If you want and import option uncomment this code

  #  active_admin_importable   do |model, hash|
  # # The first row of the file has to be keyword
  #     model.create(keyword: hash[:keyword])
  #   end

end