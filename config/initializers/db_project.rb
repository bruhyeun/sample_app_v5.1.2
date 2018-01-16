# save project database settings in global var
DB_PROJECT = YAML::load(ERB.new(File.read(Rails.root.join("config","database_project.yml"))).result)[Rails.env]