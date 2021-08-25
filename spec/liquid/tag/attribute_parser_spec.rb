# frozen_string_literal: true

RSpec.describe Liquid::Tag::AttributeParser do
  subject(:attribute_parser) { described_class }

  it "has a version number" do
    expect(Liquid::Tag::AttributeParser::VERSION).not_to be nil
  end

  describe "#attributes" do
    describe "parses string values" do
      it "string='mystring'" do
        expect(attribute_parser.new("string='mystring'").attributes).to eq(
          { string: "mystring" }
        )
      end

      it "string='my string'" do
        expect(attribute_parser.new("string='my string'").attributes).to eq(
          { string: "my string" }
        )
      end
    end

    describe "parses boolean values" do
      it "boolean=true" do
        expect(attribute_parser.new("boolean=true").attributes).to eq(
          { boolean: true }
        )
      end

      it "boolean=false" do
        expect(attribute_parser.new("boolean=false").attributes).to eq(
          { boolean: false }
        )
      end
    end

    describe "parses integer values" do
      it "integer=123" do
        expect(attribute_parser.new("integer=123").attributes).to eq(
          { integer: 123 }
        )
      end

      it "integer=+123" do
        expect(attribute_parser.new("integer=+123").attributes).to eq(
          { integer: 123 }
        )
      end

      it "integer=-123" do
        expect(attribute_parser.new("integer=-123").attributes).to eq(
          { integer: -123 }
        )
      end
    end

    describe "parses float values" do
      it "float=1.23" do
        expect(attribute_parser.new("float=1.23").attributes).to eq(
          { float: 1.23 }
        )
      end

      it "float=+1.23" do
        expect(attribute_parser.new("float=+1.23").attributes).to eq(
          { float: 1.23 }
        )
      end

      it "float=-1.23" do
        expect(attribute_parser.new("float=-1.23").attributes).to eq(
          { float: -1.23 }
        )
      end

      it "float=123.0" do
        expect(attribute_parser.new("float=123.0").attributes).to eq(
          { float: 123.0 }
        )
      end

      it "float=+123.0" do
        expect(attribute_parser.new("float=+123.0").attributes).to eq(
          { float: 123.0 }
        )
      end

      it "float=-123.0" do
        expect(attribute_parser.new("float=-123.0").attributes).to eq(
          { float: -123.0 }
        )
      end

      it "float=.123" do
        expect(attribute_parser.new("float=.123").attributes).to eq(
          { float: 0.123 }
        )
      end

      it "float=+.123" do
        expect(attribute_parser.new("float=+.123").attributes).to eq(
          { float: 0.123 }
        )
      end

      it "float=-.123" do
        expect(attribute_parser.new("float=-.123").attributes).to eq(
          { float: -0.123 }
        )
      end
    end

    describe "parses multiple values" do
      it "string='mystring' boolean=true integer=-123 float=.123" do
        expect(attribute_parser.new("string='mystring' boolean=true integer=-123 float=.123").attributes).to eq(
          { string: "mystring", boolean: true, integer: -123, float: 0.123 }
        )
      end
    end
  end
end
