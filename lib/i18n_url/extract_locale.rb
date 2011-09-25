require 'action_controller'

module I18nUrl::ExtractLocale
  extend ActiveSupport::Concern
  
  module InstanceMethods
    def extract_locale_from_url
      path = request.fullpath
      path.gsub(/^\//, '').split("/").first
    end
  end
  
end

class ActionController::Base
  include I18nUrl::ExtractLocale
end