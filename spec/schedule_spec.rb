require 'schedule'

describe Schedule do
  describe '.load(path)' do
    it "loads an empty file and returns an empty definition table" do
      expect(described_class.load('spec/data/empty.rb')).to be_empty
    end
  end
end
