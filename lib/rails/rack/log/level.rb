require 'rails/rack/log/level/version'
require 'rails/rack/log/level/rule'
require 'rails/rack/log/level/rule_set'

module Rails
  module Rack
    module Log
      class Level
        # Your code goes here...
        def initialize(app, given_options = {}, &rule_block)
          options = {
            klass: RuleSet,
            options: {}
          }.merge(given_options)
          @app = app
          @rule_set = options[:klass].new(options[:options])
          @rule_set.instance_eval(&rule_block) if block_given?
        end

        def call(env)
          matched_rule = find_first_matching_rule(env)
          if matched_rule
            Rails.logger.level = matched_rule.log_level
            response = @app.call(env)
            Rails.logger.level = matched_rule.default_log_level
            response
          else
            @app.call(env)
          end
        end

        private

        def find_first_matching_rule(env) #:nodoc:
          @rule_set.rules.detect { |rule| rule.matches?(env) }
        end
      end
    end
  end
end
