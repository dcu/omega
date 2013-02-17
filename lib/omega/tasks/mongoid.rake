namespace :mongoid do
  desc "Creates indexes for all models."
  task :index do
    Dir.glob(Omega.root("app/models/**/**/*.rb")) do |path|
      klass = File.basename(path, ".rb").classify.constantize rescue nil
      if klass
        Omega.logger.info "Creating indexes for #{klass}..."
        klass.create_indexes
      end
    end
  end
end

