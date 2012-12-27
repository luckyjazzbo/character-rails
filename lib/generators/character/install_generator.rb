module Character
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc << "Description:\n    Copies Chatacter source files to your application's app directory, adds routes and missing gems."

      source_root File.expand_path('../templates', __FILE__)

      def copy_files
        puts "Installing active admin page for Character:"
        copy_file "admin/character.rb", "app/admin/character.rb"
      end

      def add_assets
        if File.exist?('app/assets/javascripts/active_admin.js')
          partial1 = "//= require character\n\n"
          partial2 = "$(function(){ if ($('.admin_character').length > 0) window.initialize_character('http://blog-url.com/'); });\n\n"
          
          insert_into_file  "app/assets/javascripts/active_admin.js", partial1 + partial2, :after => "base\n"
        else
          puts "It doesn't look like you've installed activeadmin: active_admin.js is missing.\nPlease install it and try again."
        end

        if File.exist?('app/assets/stylesheets/active_admin.css.scss')
          insert_into_file  "app/assets/stylesheets/active_admin.css.scss",
                            "//= require character\n", :after => "base\n"
        else
          puts "It doesn't look like you've installed activeadmin: active_admin.css.scss is missing.\nPlease run: rails g active_admin:install - install it and try again."
        end
      end

      def show_congrats
        readme("README")
      end
    end
  end
end