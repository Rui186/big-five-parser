Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'big_five_parsers#index'
  post '/big_five_parser/parse', 								to: 'big_five_parsers#parse_result'
  post '/big_five_parser/submit_to_recruitbot', to: 'big_five_parsers#submit_to_recruitbot'
end
