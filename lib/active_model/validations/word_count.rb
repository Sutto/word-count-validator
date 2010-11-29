require 'active_model'
require 'active_support/i18n'
I18n.load_path << File.expand_path(File.dirname(__FILE__) + "/../locale/en.yml")

module ActiveModel
  module Validations
    
    class WordCountValidator < ActiveModel::EachValidator

      # Provide option defaults and normalize options. This is done
      # prior to check_validity! as options becomes frozen and
      # check_validity! can only report errors but not modify the
      # options.
      def initialize(options)
        options[:min] = options.delete(:minimum) if options.has_key?(:minimum)
        options[:max] = options.delete(:maximum) if options.has_key?(:maximum)
        options[:max] ||= 100
        options[:min] ||= 0
        options[:strip_tags] = true unless options.has_key?(:strip_tags)
        options[:strip_punctuation] = true unless options.has_key(:strip_punctuation)
        if options.has_key?(:in)
          range = options[:in]
          if range.present? && range.respond_to?(:min) && range.respond_to?(:max)
            options[:min], options[:max] = range.min, range.max
            options.delete :in
          end
        end
        super
      end

      def check_validity!
        raise ArgumentError, "You must provide a valid range for the number of words e.g. 2..100" if options.has_key?(:in)
        raise ArgumentError, "The min value must respond to to_i" unless options[:min].respond_to?(:to_i)
        raise ArgumentError, "The max value must respond to to_i" unless options[:max].respond_to?(:to_i)
      end

      def validate_each(record, attribute, value)
        min_words, max_words  = options[:min].to_i, options[:max].to_i
        value = ActionController::Base.helpers.strip_tags(value).gsub(/&nbsp;|&#160;/i, ' ') if options[:strip_tags]
        value.gsub! /[.(),;:!?%#$'"_+=\/-]*/, '' if options[:strip_punctuation]
        count = word_count_for(value)
        if !options[:skip_min] && count < min_words
          record.errors.add attribute, :too_few_words,  options_for(count, min_words)
        elsif !options[:skip_max] && count > max_words
          record.errors.add attribute, :too_many_words, options_for(count, max_words)
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
