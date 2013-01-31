module ActionDispatch::Routing
  class Mapper

    def mount_character_admin
      scope '/admin', :module => "Character::Admin" do
        match '/',        to: 'admin#index'
        match '/login',   to: 'sessions#create'
        match '/logout',  to: 'sessions#destroy'

        scope 'api' do
          resources :images, only: [:index, :create]

          get     '/:model_slug(.:format)',         to: 'api#index'
          post    '/:model_slug(.:format)',         to: 'api#create'
          post    '/:model_slug/reorder(.:format)', to: 'api#reorder'
          put     '/:model_slug/:id(.:format)',     to: 'api#update'
          delete  '/:model_slug/:id(.:format)',     to: 'api#destroy'
        end
      end
    end


    def mount_character_blog_at(mount_location)
      scope mount_location, :module => "Character" do
        get '/'                 => 'posts#index',    as: :blog_index
        get '/posts/:slug'      => 'posts#show',     as: :blog_post
        get '/categories/:slug' => 'posts#category', as: :blog_category
        get '/feed(.:format)'   => 'posts#feed',     as: :blog_feed
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