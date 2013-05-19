module ActionDispatch::Routing
  class Mapper

    def mount_character_admin
      scope '/admin', :module => "character/admin" do
        match '/',        to: 'admin#index', via: :all
        match '/login',   to: 'sessions#create', via: :all
        match '/logout',  to: 'sessions#destroy', via: :all

        scope 'api' do
          resources :images, only: [:index, :create]

          get     '/:model_slug(.:format)',         to: 'api#index'
          get     '/:model_slug/new(.:format)',     to: 'api#new'
          post    '/:model_slug(.:format)',         to: 'api#create'
          get     '/:model_slug/:id(.:format)',     to: 'api#show'
          get     '/:model_slug/:id/edit(.:format)',to: 'api#edit'
          put     '/:model_slug/:id(.:format)',     to: 'api#update'
          delete  '/:model_slug/:id(.:format)',     to: 'api#destroy'
          post    '/:model_slug/reorder(.:format)', to: 'api#reorder'
        end
      end
    end


    def mount_character_blog_at(mount_location)
      scope mount_location, :module => "character" do
        get '/'                 => 'posts#index',    as: :blog_index
        get '/posts/:slug'      => 'posts#show',     as: :blog_post
        get '/categories/:slug' => 'posts#category', as: :blog_category
        get '/feed(.:format)'   => 'posts#feed',     as: :blog_feed
      end
    end


    def mount_character_pages
      scope :module => "character" do
        # FIXME: get rid of match; as: :root cannot be used as it's reserved
        match '/',  to: 'pages#root', as: :root_, via: :all
        match '*a', to: 'pages#show', as: :flat_page, via: :all
      end
    end

  end
end