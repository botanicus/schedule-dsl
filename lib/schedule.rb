require 'date'
require 'forwardable'

module Schedule
  # Load schedule from definition file.
  def self.load(path)
    context = DSL.new
    context.instance_eval(File.read(path), path)
    context.rules
  end

  class RuleList
    extend Forwardable

    attr_reader :rules
    def initialize
      @rules = Array.new
    end

    def_delegators :rules, :length, :first, :empty?, :<<

    def filter(date)
      FilteredRuleList.new(date, self.rules.select { |rule|
        rule.condition.call(date)
      })
    end
  end

  class FilteredRuleList
    extend Forwardable

    attr_reader :date, :rules
    def initialize(date, rules)
      @date, @rules = date, rules
    end

    def_delegators :rules, :length, :first, :empty?, :<<

    # TODO: Call with a time frame? For instance:
    # schedule.time_frame.find('morning').create_event('Go swimming') }
    def evaluate
      self.rules.map { |rule| rule.block.call }
    end
  end

  class Rule
    attr_reader :condition, :block
    def initialize(condition, &block)
      @condition, @block = condition, block
    end
  end

  class DSL
    attr_reader :rules
    def initialize
      @rules = RuleList.new
    end

    def rule(condition, &block)
      self.rules << Rule.new(condition, &block)
    end
  end
end
