namespace :authentication do
  task :install do
    system "rsync -ruv vendor/plugins/authentication/db/migrate db"
    puts "Add [include Authentication] to ApplicationController"
  end
end