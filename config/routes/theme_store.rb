namespace :theme_store, path: '/' do
  get 'authors_themes'    => 'themes_store#authors_themes'
  get 'demo'              => 'themes_store#demo'
  get 'homepage'          => 'themes_store#homepage'
  get 'installing'        => 'themes_store#installing'
  get 'learn_more'        => 'themes_store#learn_more'
  get 'login'             => 'themes_store#login'
  get 'preview_in_store'  => 'themes_store#preview_in_store'
  get 'template_page'     => 'themes_store#template_page'
  get 'theme_page'        => 'themes_store#theme_page'
end