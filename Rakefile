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

desc "Run simple python server at http://localhost:8000"
task :stat do
  system("open http://localhost:8000")
  system("cd build && python -m SimpleHTTPServer 8000")
end

desc "Build and deploy the website"
task :deploy do
  puts "-----> Deploying website via rsync to #{ENV['SSH_HOST']}"
  status = system("rsync -aP build/ #{ENV['SSH_USER']}@#{ENV['SSH_HOST']}:#{ENV['SSH_DIR']} --delete")
  puts status ? "OK" : "FAILED"
end
