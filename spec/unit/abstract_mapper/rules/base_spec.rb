# encoding: utf-8

describe AbstractMapper::Rules::Base do

  let(:rule)  { test.new(*nodes) }
  let(:test)  { Class.new(described_class) }
  let(:nodes) { [node] }
  let(:node)  { AbstractMapper::AST::Node.new }

  describe ".new" do
    subject { rule }

    it { is_expected.to be_immutable }
  end # describe .new

  describe "#nodes" do
    subject { rule.nodes }

    it { is_expected.to eql nodes }
    it { is_expected.to be_immutable }

    it "doesn't freeze the source" do
      expect { subject }.not_to change { nodes.frozen? }
    end
  end # describe #nodes

  describe "#call" do
    subject { rule.call }

    context "by default" do
      it { is_expected.to eql nodes }
    end

    context "when #optimize? returns true" do
      before { test.send(:define_method, :optimize?) { true } }

      it { is_expected.to eql nodes }
    end

    context "when #optimize is defined" do
      before { test.send(:define_method, :optimize) { :foo } }

      it { is_expected.to eql nodes }
    end

    context "when #optimize? returns true and #optimize is defined" do
      before { test.send(:define_method, :optimize?) { true } }
      before { test.send(:define_method, :optimize)  { :foo } }

      it { is_expected.to eql [:foo] }
    end

    context "when #optimize returns nils" do
      before { test.send(:define_method, :optimize?) { true } }
      before { test.send(:define_method, :optimize) { [nil, nil] } }

      it { is_expected.to eql [] }
    end
  end # describe #call

  describe ".transproc" do
    subject { test.transproc[array] }

    before do
      test.send(:define_method, :optimize?) { true          }
      test.send(:define_method, :optimize)  { nodes.reverse }
    end

    let(:array) { [1, 2, 3] }

    context "with default composer" do
      it { is_expected.to eql array }
    end

    context "with another composer" do
      before { allow(test).to receive(:composer) { :compact } }

      it { is_expected.to eql [2, 3, 1] }
    end
  end # describe .transproc

end # describe AbstractMapper::Rules::Base
