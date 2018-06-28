require 'dotenv/load'

desc "Run the preview server at http://localhost:4567"
task :preview do
  system("middleman server")
end

desc "Build the website from source"
task :build do
  puts "-----> Building website"
  status = system("middleman build --clean")
  puts status ? "OK" : "FAILED"
end

desc "Build and deploy the website"
task :deploy do
  puts "-----> Deploying website via rsync to #{SSH_HOST}"
  status = system("rsync -aP build/ #{ENV['SSH_USER']}@#{ENV['SSH_HOST']}:#{ENV['SSH_DIR']}")
  puts status ? "OK" : "FAILED"
end
