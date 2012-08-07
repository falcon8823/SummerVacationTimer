Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, 
      SummerVacationTimer::Application.config.consumer_key,
      SummerVacationTimer::Application.config.consumer_secret
end
