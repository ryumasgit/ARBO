Rails.application.routes.draw do
  # メンバー用
  devise_for :members,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # 管理者
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :member do
  post "guest_sign_in" => "public/sessions#guest_sign_in"
  end

  scope module: :public do
    root to: "homes#top"
    get "welcome" => "homes#welcome"
    resources :members, only: [], param: :member_name do
      patch "update" => "members#update"
      get "my_page" => "members#show"
      get "information/edit" => "members#edit"
      get "confirm_withdraw"
      patch "withdraw"
      resource :relationships, only: [:create, :destroy]
      get "follows" => "relationships#follows"
      get "followers" => "relationships#followers"
      resources :badges, only: [:index]
      resources :member_tags, only: [:index]
      resources :bookmark_museums, only: [:index]
      resources :bookmark_exhibitions, only: [:index]
    end
    resources :reviews, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
      resources :review_comments, only: [:create, :index, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    resources :member_tags, only: [:create, :destroy]
    resources :museums, only: [:show, :index] do
      resource :bookmark_museums, only: [:create, :destroy]
    end
    resources :exhibitions, only: [:show, :index] do
      get "reviews" => "exhibitions#reviews"
      resource :bookmark_exhibitions, only: [:create, :destroy]
    end
    resources :searches, only: [:new, :index]
  end

  namespace :admin do
    root to: "homes#top"
    resources :members, only: [:index, :show, :edit, :update] do
      get "follows" => "relationships#follows"
      get "followers" => "relationships#followers"
      resources :badges, only: [] do
        get "earned" => "badges#badges"
      end
      resources :member_tags, only: [:index]
      resources :bookmark_museums, only: [:index]
      resources :bookmark_exhibitions, only: [:index]
    end
    resources :badges, only: [:new, :create, :index, :edit, :update, :destroy]
    resources :reviews, only: [:show, :index, :destroy] do
      resources :review_comments, only: [:index, :destroy]
    end
    resources :museums, only: [:new, :create, :show, :index, :edit, :update, :destroy]
    resources :exhibitions, only: [:new, :create, :show, :index, :edit, :update, :destroy] do
      get "reviews" => "exhibitions#reviews"
    end
    resources :artists, only: [:new, :create, :show, :index, :edit, :update, :destroy]
  end
end
