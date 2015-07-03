# encoding: utf-8

describe AbstractMapper::SoleRule do

  let(:rule)  { test.new(node) }
  let(:test)  { AbstractMapper::Test::Rule = Class.new(described_class) }
  let(:nodes) { [node] }
  let(:node)  { double }

  describe ".composer" do

    subject { test.composer }
    it { is_expected.to eql :filter }

  end # describe .pair?

  describe ".new" do

    subject { rule }

    it { is_expected.to be_kind_of AbstractMapper::Rule }
    it { is_expected.to be_frozen }

    it "denies second argument" do
      expect { test.new(node, node) }.to raise_error(ArgumentError)
    end

  end # describe .new

  describe "#node" do

    subject { rule.node }
    it { is_expected.to eql node }

  end # describe #node

  describe "#transproc" do

    before do
      test.send(:define_method, :optimize?) { node > 3          }
      test.send(:define_method, :optimize)  { -node if node < 7 }
    end

    subject { test.transproc[array] }

    let(:array) { [5, 1, 38, 4] }
    it { is_expected.to eql [-5, 1, -4] }

  end # describe #transproc

end # describe AbstractMapper::SoleRule