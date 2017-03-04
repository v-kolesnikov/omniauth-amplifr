require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    # Authenticate to Amplifr.com utilizing OAuth 2.0
    # http://docs.amplifr.apiary.io/
    class Amplifr < OmniAuth::Strategies::OAuth2
      option :name, 'amplifr'

      option :authorize_options, [
        :access_type,
        :scope,
        :state,
        :redirect_uri
      ]

      option :client_options,
             site: 'https://amplifr.com',
             authorize_url: '/oauth/authorize',
             token_url: '/oauth/token'

      option :user_info_url, "https://amplifr.com/api/v1/authorize_token"

      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end

      uid { info['id'] }

      extra do
        { raw_info: raw_info }
      end

      info do
        return {} unless raw_info.dig('result', 'user')
        raw_info.dig('result', 'user')
      end

      # Amplifr provides information about current user in the following format:
      #
      #   $ curl -s -XPOST https://amplifr.com/api/v1/authorize_token?access_token=YOUR_ACCESS_TOKEN
      #   {
      #     "ok": true,
      #     "result": {
      #       "status": "authorized",
      #       "user": {
      #         "confirmed": true,
      #         "email": "me@example.com",
      #         "id": 42,
      #         "name": "Your Name",
      #         "timezone": "Europe/Moscow",
      #         "tzUtcOffset": 3.0
      #       }
      #     }
      #   }
      def raw_info
        user_info = access_token.post(options[:user_info_url]).parsed
        user_info['ok'] == true ? user_info : {}
      end
    end
  end
end
