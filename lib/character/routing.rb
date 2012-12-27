module ActionDispatch::Routing
  class Mapper
    def mount_character
      scope '/admin', :module => "Character" do
        scope 'character' do
          resources :posts, only: [:index, :create, :update, :destroy]
        end
      end
    end
  end
end