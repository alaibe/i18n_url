module ActionDispatch
  module Routing
    class RouteSet
    
      class NamedRouteCollection
        
        def add(name)
          routes[name.to_sym] = nil
          define_proxy_named_route(name)
        end
        
        def define_proxy_named_route(name)
          {:url => {:only_path => false}, :path => {:only_path => true}}.each do |kind, opts|
            define_proxy_helper name, kind, hash
          end
        end
        
        
        def define_proxy_helper(name, kind, hash)
          selector = url_helper_name(name, kind)
          hash_access_method = hash_access_name(name, kind)          
          @module.module_eval <<-END_EVAL, __FILE__, __LINE__ + 1
            remove_possible_method :#{selector}
            def #{selector}(*args)
              send(I18n.locale.to_s+"_#{selector}", *args)
            end
          END_EVAL
          helpers << selector
        end
        
      end
      
      def name_route_proxy(name = nil)
        named_routes.add(name) if name
      end
        
    end
  end
end