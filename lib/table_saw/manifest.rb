# frozen_string_literal: true

require 'yaml'

module TableSaw
  class Manifest
    class Table
      attr_reader :variables, :config

      def initialize(variables, config)
        @variables = variables
        @config = config
      end

      def table
        config['table']
      end

      alias name table

      def query
        if config['query']
          format(config['query'], variables.transform_keys(&:to_sym))
        else
          "select id from #{table}"
        end
      end

      # rubocop:disable Naming/PredicateName
      def has_many
        config.fetch('has_many', [])
      end
      # rubocop:enable Naming/PredicateName
    end

    def self.instance
      raise ArgumentError, 'Could not find manifest file' unless File.exist?(TableSaw.configuration.manifest)

      new(YAML.safe_load(File.read(TableSaw.configuration.manifest)))
    end

    attr_reader :config

    def initialize(config)
      @config = config
    end

    def variables
      config['variables']
    end

    def tables
      @tables ||= config['tables'].map { |entry| Table.new(variables, entry) }.each_with_object({}) do |t, memo|
        memo[t.name] = t
      end
    end
  end
end