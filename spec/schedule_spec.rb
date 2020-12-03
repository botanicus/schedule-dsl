require 'schedule'

describe Schedule do
  describe '.load(path)' do
    it "loads an empty file and returns an empty definition table" do
      expect(described_class.load('spec/data/empty.rb')).to be_empty
    end

    it "loads definitions from a file and returns the definition table" do
      expect(described_class.load('spec/data/basic.rb')).not_to be_empty
    end
  end

  describe "basic rule list" do
    let(:date) do
      Date.new(2020, 12, 1)
    end

    subject do
      described_class.load('spec/data/basic.rb')
    end

    it "returns a filtered list of rules which evaluated true for given date" do
      expect(subject.filter(date).length).to eql(2)
    end
  end
end
