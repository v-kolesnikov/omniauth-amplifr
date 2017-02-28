require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Amplifr < OmniAuth::Strategies::OAuth2
      option :name, :amplifr

      option :client_options, site: 'https://amplifr.com',
                              authorize_url: '/oauth/authorize/'

      def callback_url
        full_host + script_name + callback_path
      end

      uid { nil }

      info do
        {}
      end

      def raw_info
        {}
      end
    end
  end
end
