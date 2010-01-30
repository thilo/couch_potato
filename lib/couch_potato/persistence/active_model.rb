module CouchPotato
  module Persistence
    module ActiveModel
      begin
        require 'active_model'

        class ModelName < String
          attr_reader :name, :human, :partial_path, :singular, :plural
          def initialize(class_name)
            @name = class_name
            @human = class_name.gsub(/[A-Z]/) {|match| " #{match}"}.strip
            @partial_path
            @singular
            @plural
          end
        end

        def self.included(base)
          base.extend ClassMethods
          base.class_eval do
            alias_method :new_record?, :new?
          end
        end

        def to_model
          self
        end

        def errors
          super || []
        end

        def destroyed?
          !!_deleted
        end

        module ClassMethods
          def model_name
            @model_name ||= ::ActiveModel::Name.new(self)
          end
        end

      rescue LoadError
        # if it's not installed you probably don't want to use it anyway
      end
    end
  end
end

