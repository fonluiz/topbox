Rails.application.config.middleware.use OmniAuth::Builder do
     provider :facebook, '536897893166798', "77df3395285450e70fafd7a32f93d109" , :scope => "email", :info_fields => 'email, first_name, last_name'
   end