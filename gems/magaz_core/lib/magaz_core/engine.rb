module MagazCore
  class Engine < ::Rails::Engine
    isolate_namespace MagazCore

    def for_wrapper_app_config_include_dir(app:, dir:)
      unless app.root.to_s.match root.to_s
        config.to_prepare do
          Dir.glob(app.root + "#{dir}/**/*.rb").each {|c| require_dependency(c)}
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

    initializer :append_services do |app|
      for_wrapper_app_config_include_dir app: app, dir: "app/services"
    end

    initializer :append_uploaders do |app|
      for_wrapper_app_config_include_dir app: app, dir: "app/uploaders"
    end    
  end
end
