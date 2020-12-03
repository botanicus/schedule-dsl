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

  let(:date) do
    Date.new(2020, 12, 1)
  end

  context "basic rule list" do
    let(:table) do
      described_class.load('spec/data/basic.rb')
    end

    describe '#filter' do
      it "returns a filtered list of rules which evaluated true for given date" do
        expect(table.filter(date).length).to eql(2)
      end
    end

    describe '#evaluate' do
      subject { table.filter(date) }

      it "returns a list of outputs that were evaluated from each rule's block" do
        expect(subject.evaluate).to eql(["Go swimming", "Read a book"])
      end
    end
  end

  context "standard rule list" do
    let(:time_frames) {{
      morning: Array.new,
      evening: Array.new
    }}

    let(:table) do
      described_class.load('spec/data/standard.rb')
    end

    describe '#filter' do
      it "returns a filtered list of rules which evaluated true for given date" do
        expect(table.filter(date).length).to eql(2)
      end
    end

    describe '#evaluate' do
      subject { table.filter(date) }

      it "returns a list of outputs that were evaluated from each rule's block" do
        subject.evaluate(time_frames)
        expect(time_frames).to eql(morning: ["Go swimming"], evening: ["Read a book"])
      end
    end
  end
end
