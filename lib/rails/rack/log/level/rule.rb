module Rails
  module Rack
    module Log
      class Level
        class Rule
          attr_reader :condition, :options

          def initialize(condition, options = {}) #:nodoc:
            @condition, @options = condition, normalize_options(options)
          end

          def default_log_level
            (options[:default_level] || 3).to_i
          end

          def log_level
            options[:level].to_i
          end

          def matches?(rack_env)
            path = build_path_from_env(rack_env)
            string_matches?(path, self.condition)
          end

          def condition
            return @static_condition if @static_condition
            @condition.respond_to?(:call) ? @condition.call : @static_condition = @condition
          end


          protected

          def is_a_regexp?(obj)
            obj.is_a?(Regexp) || (Object.const_defined?(:Oniguruma) && obj.is_a?(Oniguruma::ORegexp))
          end

          def string_matches?(string, matcher)
            if self.is_a_regexp?(matcher)
              string =~ matcher
            elsif matcher.is_a?(String)
              string == matcher
            elsif matcher.is_a?(Symbol)
              string.downcase == matcher.to_s.downcase
            else
              false
            end
          end

          def build_path_from_env(env)
            path = env['PATH_INFO'] || ''
            path += "?#{env['QUERY_STRING']}" unless env['QUERY_STRING'].nil? || env['QUERY_STRING'].empty?
            path
          end

          def normalize_options(arg)
            options = arg.respond_to?(:call) ? {:if => arg} : arg
            options.symbolize_keys! if options.respond_to? :symbolize_keys!
            options.freeze
          end
        end
      end
    end
  end
end
