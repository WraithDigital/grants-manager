Rails.application.routes.draw do

  root to: 'grants#home'

  get  'login',  to: 'sessions#new'
  post 'login',  to: 'sessions#create'
  get  'logout', to: 'sessions#destroy'

  resources :grants, except: [:show, :destroy]

  resources :agencies, except: [:show, :destroy]

  resources :applicant_types, except: [:show, :destroy]

  resources :reviews, only: [:index, :show, :create]
  patch 'reviews/:id/approve', to: 'reviews#approve', as: 'review_approve'
  patch 'reviews/:id/reject',  to: 'reviews#reject',  as: 'review_reject'

  get 'sync/grant/:id', to: 'sync#grant', as: 'sync_grant'

  post 'api/import', to: 'api#import'

  post 'grants/validate', to: 'api#validate'

end
