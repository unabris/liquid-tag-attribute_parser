# frozen_string_literal: true

require_relative "attribute_parser/version"

module Liquid
  class Tag
    class AttributeParser # :nodoc:
      # TODO: Improve the key selecting regexp
      STRING_ATTRIBUTES  = /[^\s]+=(?:'[^']+')|[^\s]+=(?:"[^"]+")/.freeze
      BOOLEAN_ATTRIBUTES = /[^\s]+=(?:true|false)/.freeze
      NUMBER_ATTRIBUTES  = /[^\s]+=(?:[+-]?(?:[0-9]*[.])?[0-9]+)/.freeze

      attr_reader :attributes

      def initialize(raw)
        @raw = raw
        @attributes = {}

        parse
      end

      private

      def parse
        %i[string boolean number].each do |kind|
          regexp = Object.const_get("#{self.class}::#{kind.upcase}_ATTRIBUTES")

          instance_variable_set("@#{kind}_attributes", @raw.scan(regexp).map { |a| a.split("=") })
          send("parse_#{kind}_attributes")
        end
      end

      def parse_string_attributes
        @string_attributes.each do |k, v|
          # TODO: Fin a better way for parsing `v` without `eval`
          @attributes[k.to_sym] = eval(v) # rubocop:disable Security/Eval
        end
      end

      def parse_boolean_attributes
        @boolean_attributes.each do |k, v|
          # TODO: Fin a better way for parsing `v` without `eval`
          @attributes[k.to_sym] = eval(v) # rubocop:disable Security/Eval
        end
      end

      def parse_number_attributes
        @number_attributes.each do |k, v|
          # Add leading zero when `v` starts with `+.`, `-.` or just `.` because it breaks the `eval` statement
          v.gsub!(/^[+-]?(\.)/) { |m| m.gsub!(Regexp.last_match(1), "0.") }

          # TODO: Fin a better way for parsing `v` without `eval`
          @attributes[k.to_sym] = eval(v) # rubocop:disable Security/Eval
        end
      end
    end
  end
end
