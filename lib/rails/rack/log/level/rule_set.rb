module Rails
  module Rack
    module Log
      class Level
        class RuleSet
          attr_reader :rules
          def initialize(options = {})#:nodoc:
            @rules = []
          end

          protected

          def add_rule(condition, options = {}) #:nodoc:
            @rules << Rule.new(condition, options)
          end
        end
      end
    end
  end
end
