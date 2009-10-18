namespace :authentication do
  task :install do
    #system "rsync -ruv vendor/plugins/authentication/db/migrate db"
    source_dir      = "#{RAILS_ROOT}/vendor/plugins/authentication/db/migrate"
    destination_dir = "#{RAILS_ROOT}/db/migrate"
    
    files = Dir.new(source_dir).entries

    for file in files
      timestamp = Time.now.strftime("%Y%m%d%H%M%S")
      unless file == "." || file == ".."
        new_file_name = "#{timestamp}_#{file[15..-1]}"
        system "cp #{source_dir}/#{file} #{destination_dir}/#{new_file_name}"
      end
    end
    puts "Add [include Authentication] to your ApplicationController"
  end
end