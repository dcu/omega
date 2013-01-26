module Omega
  class Static
    def initialize(app, options = {})
      @app = app
      @public_folder = options[:public_folder]
      @headers = options[:headers] || {'Cache-Control' => 'public, max-age=31536000', 'Access-Control-Allow-Origin' => '*'}

      @server ||= Rack::File.new(@public_folder, @headers)
    end

    def call(env)
      if can_serve?(env['PATH_INFO'])
        @server.call(env)
      else
        @app.call(env)
      end
    end

    def can_serve?(path)
      File.file?("#{@public_folder}#{path}") && File.readable?("#{@public_folder}#{path}") #&& !Rack::Utils.unescape(path).include?("..")
    end
  end
end

