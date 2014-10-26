module MagazCore
  class Engine < ::Rails::Engine
    isolate_namespace MagazCore

    def _include_dependencies_at(dir)
      Dir.glob(app.root + "#{dir}/**/*.rb").each {|c| require_dependency(c)}
    end

    def for_wrapper_app_config_include_dir(dir)
      unless app.root.to_s.match root.to_s
        config.to_prepare do
          _include_dependencies_at dir
        end
      end
    end

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    initializer :append_uploaders do |app|
      for_wrapper_app_config_include_dir "app/uploaders"
    end

    initializer :append_constraints do |app|
      for_wrapper_app_config_include_dir "app/uploaders"
    end
    
  end
end
