module ActionDispatch::Routing
  class Mapper
    def mount_character
      scope '/admin', :module => "Character" do
        resources :posts
      end
    end
  end
end