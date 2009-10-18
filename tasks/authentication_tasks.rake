namespace :authentication do
  task :install do
    source_dir      = "#{RAILS_ROOT}/vendor/plugins/authentication/db/migrate"
    destination_dir = "#{RAILS_ROOT}/db/migrate"
    
    files = Dir.new(source_dir).entries.reverse
    version_number = Time.now.strftime("%Y%m%d%H%M%S").to_i
    
    unless File.directory?(destination_dir)
      system "mkdir #{destination_dir}"
    end

    for file in files
      unless file == "." || file == ".."
        new_file_name = "#{version_number.to_s}_#{file[15..-1]}"
        system "cp #{source_dir}/#{file} #{destination_dir}/#{new_file_name}"
        version_number = version_number + 1
      end
    end
    puts "Add [include Authentication] to your ApplicationController"
  end
end