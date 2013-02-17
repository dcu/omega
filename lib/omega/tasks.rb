load 'omega/tasks/mongoid.rake'

Dir.glob(Omega.root("lib/tasks/**/**/*.rake")) do |task_path|
  load task_path
end

