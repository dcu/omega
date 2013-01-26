module Omega
  class Assets
    def initialize(app)
      @app = app
    end

    def call(env)
      if env['PATH_INFO'].start_with?("/assets/")
        Omega::Assets.environment.call(env)
      else
        @app.call(env)
      end
    end

    def self.environment
      @environment ||= Sprockets::Environment.new(Omega.root)
    end

    def self.setup!
      self.environment.append_path("#{Omega.root}/assets")
      self.environment.append_path("#{Omega.root}/app")
    end
  end
end

