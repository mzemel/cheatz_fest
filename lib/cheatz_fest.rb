require "cheatz_fest/version"
require 'pry'

module CheatzFest

  def self.included(base)
    base.class_eval do
      def cheat(*args)
        method_def, *spec = spec_as_string(get_test_line_range)
        assert = spec.pop
        spec = spec.map {|l| l += "\n"; l}
        eval spec.join
      end

      private

      def spec_file
        @spec_file ||= set_spec_file
      end

      def set_spec_file
        spec_file = {}
        File.read("#{klass}/test/#{klass}_test.rb").each_line.with_index do |line, i|
          spec_file[i+1] = line.chomp
        end
        spec_file
      end

      def spec_as_string(range)
        range.map {|l| @spec_file[l] }
      end

      def get_test_line_range
        assert_line, method_def = get_line_and_method
        method_def_line, _ = spec_file.find {|k, v| v =~ /#{method_def}/}
        method_def_line .. assert_line.to_i
      end

      def get_line_and_method
        caller.map do |l|
          l.match(/^#{klass}\/test\/#{klass}_test.rb:(\d+):in `([a-z\d_]+)'/).captures rescue nil
        end.compact.flatten
      end

      def klass
        self.class.to_s.downcase
      end
    end
  end
end