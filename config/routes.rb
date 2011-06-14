ValveTime::Application.routes.draw do

  root :to => "convert#index"

  match 'convert' => 'convert#index'
  match 'autocomplete' => 'convert#autocomplete', :as => :autocomplete

end
