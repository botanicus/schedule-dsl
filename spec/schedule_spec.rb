require 'schedule'

describe Schedule do
  describe '.load(path)' do
    it "loads an empty file and returns an empty definition table" do
      expect(described_class.load('spec/data/empty.rb')).to be_empty
    end

    it "loads definitions from a file and returns the definition table" do
      table = described_class.load('spec/data/basic.rb')
      expect(table).not_to be_empty
      expect(table.length).to be(1)

      rule = table.first
      expect(rule.condition.call).to be(true)
      expect(rule.block.call).to eql("Go swimming")
    end
  end
end
