set :build_script, "/home/blake/bin/blakesmith-compile"
set :deployment_directory, "/home/blake/public_html/blakesmith"

role :server, "stiletto.blakesmith.me"
set :user, "blake"

desc "Runs the remote jekyll script to compile and deploy the site"
task :compile_source, :role => :server do
  run "bash #{build_script}"
end

desc "Cleans target directory for a fresh build and compile"
task :clean, :role => :server do
  run "rm -rf #{deployment_directory}/*"
end

desc "Cleans and rebuilds"
task :clean_install, :role => :server do
  clean
  compile_source
end

# vim: set syntax=ruby:
