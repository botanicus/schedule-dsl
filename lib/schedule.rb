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
      FilteredRuleList.new(
        date.extend(DateExts),
        self.rules.select { |rule| rule.condition.call(date) })
    end
  end

  class FilteredRuleList
    extend Forwardable

    attr_reader :date, :rules
    def initialize(date, rules)
      @date, @rules = date, rules
    end

    def_delegators :rules, :length, :first, :empty?, :<<

    # This method can be used in one of two ways:
    #
    # Either directly collect the results or pass a collection object,
    # fill it in and then use that object directly rather than using
    # the output of this method.
    #
    # # Collecting the results directly
    #
    #   rule -> (date) { date.tuesday? } do
    #     "Go swimming"
    #   end
    #
    #   list.evaluate # => ["Go swimming"]
    #
    # # Using a collection object
    #
    #   rule -> (date) { date.tuesday? } do |time_frames|
    #     time_frames[:morning] << "Go swimming"
    #   end
    #
    #   time_frames = {morning: Array.new}
    #   list.evaluate(time_frames) # Ignore the result.
    #   time_frames # => {morning: "Go swimming"}
    def evaluate(*args)
      self.rules.map { |rule| rule.block.call(*args) }
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

  module DateExts
    def weekend?
      self.saturday? || self.sunday?
    end

    def weekday?
      !self.weekend?
    end

    def last_day_of_a_month?
      self == Date.new(self.year, self.month, -1)
    end
  end
end
