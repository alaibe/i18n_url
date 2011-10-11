require "action_dispatch"
module ActionDispatch::Routing
  class Mapper

    def i18n_url(&block)
      @locales = I18n.available_locales
      yield
      @locales = nil
    end
      
    module Base
      def match(path, options)
        if @locales
          @locales.each do |locale|
            mapping = MappingLocalized.new(locale, @set, @scope, path, options || {})
            app, conditions, requirements, defaults, as, anchor = mapping.to_route
            @set.add_route(app, conditions, requirements, defaults, as, anchor)
          end
          @set.name_route_proxy options[:as]
        else
          mapping = Mapping.new(@set, @scope, path, options || {})
          app, conditions, requirements, defaults, as, anchor = mapping.to_route
          @set.add_route(app, conditions, requirements, defaults, as, anchor)
        end
      end
    end
    
    class MappingLocalized < Mapping

      def initialize(locale, set, scope, path, options)
        @locale = locale
        I18n.locale = locale
        path.gsub!(/^\//, '')
        format = '(.:format)'
        path.gsub!( format, '')   
        translate_route path
        path = "/#{@locale}/" + @localized_path.join("/")
        super(set, scope, path, options)
        localized_name_route
      end
        
      def localized_name_route
        original_name = @options[:as]
        @options[:as] = "#{@locale}_#{original_name}" if original_name
      end

      def translate_route path
        path.split("/").each do |word|
          if word[0] == ":"
            (@localized_path ||= []) << word
          else
            (@localized_path ||= []) << I18n.t(word,:scope => :routes, :default => word)
          end
        end
      end
    end
        
  end
end