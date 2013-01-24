module ActionDispatch::Routing
  class Mapper

    def mount_character_admin
      scope '/admin', :module => "Character::Admin" do
        match '/', to: 'app#index'

        scope 'character' do
          put '/categories-reorder',  to: 'categories#reorder'
          put '/pages-reorder',       to: 'pages#reorder'
          resources :posts,      only: [:index, :create, :update, :destroy]
          resources :categories, only: [:index, :create, :update, :destroy]
          resources :images,     only: [:create]
          resources :pages,      only: [:index, :create, :update, :destroy]
        end
      end
    end


    def mount_character_blog_at(mount_location)
      scope mount_location, :module => "Character" do
        get '/'             => 'posts#index',    as: :blog_index
        get '/posts/:slug'  => 'posts#show',     as: :blog_post
        get '/:slug'        => 'posts#category', as: :blog_category
      end
    end


    def mount_character_pages
      scope :module => "Character" do
        match '/',  to: 'pages#root'
        match '*a', to: 'pages#show'
      end
    end
    
  end
end