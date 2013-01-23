module Omega
  class Assets
    def self.environment
      @environment ||= Sprockets::Environment.new(Omega.root)
    end

    def self.setup!
      self.environment.append_path("#{Omega.root}/assets")
    end
  end
end

