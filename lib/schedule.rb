module Schedule
  # Load schedule from definition file.
  def self.load(path)
    context = DSL.new
    context.instance_eval(File.read(path), path)
    context.rules
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
      @rules = Array.new
    end

    def rule(condition, &block)
      self.rules << Rule.new(condition, &block)
    end
  end
end
