namespace :pictures do
  desc "Recreate Carrierwave versions"
  task :recreate_versions => :environment do
    Picture.all.each {|p| p.path.recreate_versions! if p.path?}
  end
end