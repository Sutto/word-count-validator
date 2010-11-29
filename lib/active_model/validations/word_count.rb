require 'active_model'
require 'active_support/i18n'
I18n.load_path << File.expand_path(File.dirname(__FILE__) + "/../locale/en.yml")

module ActiveModel
  module Validations
    
    class WordCountValidator < ActiveModel::EachValidator

      def check_validity!
        if options.has_key?(:in)
          range = options.delete(:in)
          unless range.present? && range.respond_to?(:min) && range.respond_to?(:max)
            raise ArgumentError, "You must provide a valid range for the number of words e.g. 2..100"
          end
          options[:min], options[:max] = range.min, range.max
        end
        options[:min] = options.delete(:minimum) if options.has_key?(:minimum)
        options[:max] = options.delete(:maximum) if options.has_key?(:maximum)
        options[:max] ||= 100
        options[:min] ||= 0
        raise ArgumentError, "The min value must respond to to_i" unless options[:min].respond_to?(:to_i)
        raise ArgumentError, "The max value must respond to to_i" unless options[:max].respond_to?(:to_i)
        # Finally, normalize the min values.
        options[:min] = options[:min].to_i
        options[:max] = options[:max].to_i
        options[:strip_tags] = true
      end

      def validate_each(record, attribute, value)
        min_words, max_words  = options[:min], options[:max]
        value = ActionController::Base.helpers.strip_tags value if options[:strip_tags]
        count = word_count_for(value)
        if !options[:skip_min] && count < min_words
          record.errors.add attribute, :too_few_words,  options_for(min_words, count)
        elsif !options[:skip_max] && count > max_words
          record.errors.add attribute, :too_many_words, options_for(max_words, count)
        end 
      end

      def word_count_for(value)
        value.to_s.scan(/\w+/).size
      end
      
      def base_options
        options.except(:in, :min, :max, :skip_max, :skip_min)
      end
      
      def options_for(current, expected)
        base_options.merge :expected_count => expected, :actual_count => current
      end

    end
    
    module HelperMethods
      
      # Lets you validate that given attributes have a word count within a specific range.
      def validates_word_count(*attr_names)
        validates_with WordCountValidator, _merge_attributes(attr_names)
      end

    end
  end
end
