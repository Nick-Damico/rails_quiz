# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

# Pagy::SyncTask.new(resource, destination, *targets)
# Replace 'pagy*' with the file you picked
# Pagy::SyncTask.new(:stylesheet, Rails.root.join('app/stylesheets'), 'pagy*')

Pagy::SyncTask.new(:stylesheet, Rails.root.join("app/assets/stylesheets"), "pagy-tailwind.css")
Pagy::SyncTask.new(:javascript, Rails.root.join("app/javascript"), "pagy.min.js")
