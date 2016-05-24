namespace :theme_store, path: '/' do
  get 'authors_themes'    => 'welcome#authors_themes'
  get 'demo'              => 'welcome#demo'
  get 'homepage'          => 'welcome#homepage'
  get 'installing'        => 'welcome#installing'
  get 'learn_more'        => 'welcome#learn_more'
  get 'login'             => 'welcome#login'
  get 'preview_in_store'  => 'welcome#preview_in_store'
  get 'template_page'     => 'welcome#template_page'
  get 'theme_page'        => 'welcome#theme_page'
end