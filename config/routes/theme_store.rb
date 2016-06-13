namespace :theme_store, path: '/' do
  get "authors_themes/:id"    => 'welcome#authors_themes', as: "authors_themes"
  get "demo/:id"              => 'welcome#demo', as: "demo"
  get 'homepage'              => 'welcome#homepage'
  get 'installing'            => 'welcome#installing'
  get 'learn_more'            => 'welcome#learn_more'
  get 'login'                 => 'welcome#login'
  get 'preview_in_store'      => 'welcome#preview_in_store'
  get "template_page/:id"     => 'welcome#template_page', as: "template_page"
  get "theme_page/:id"        => 'welcome#theme_page', as: "theme_page"
  get 'themes'                => 'themes#index'
  get "theme/:id/style/:style_id"   => 'themes#show_style', as: "style"
  get 'preview_in_your_store' => 'themes#preview_in_your_store'
  get 'buy_theme'             => 'themes#buy_theme'
  get 'view_demo'             => 'themes#view_demo'
  get 'support'               => 'themes#support'
  get 'documentation'         => 'themes#documentation'
  get 'terms_of_service'      => 'themes#terms_of_service'
  get "author/:id"            => 'themes#show_author', as: "author"
  get "industry"              => 'themes#show_industry_styles'
  get "create_review"         => 'themes#create_review'
  get "/"                     => 'themes#index'
end