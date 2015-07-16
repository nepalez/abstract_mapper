# encoding: utf-8

class AbstractMapper

  describe AbstractMapper::Command do

    let(:command)   { described_class.new name, klass, converter }
    let(:name)      { "foo"                                      }
    let(:klass)     { Class.new                                  }
    let(:converter) { -> *args { args.reverse }                  }
    let(:arguments) { [:bar, baz: :QUX]                          }
    let(:block)     { proc { :foo }                              }

    describe ".new" do

      subject { command }

      it { is_expected.to be_frozen }

    end # describe .new

    describe "#name" do

      subject { command.name }

      it { is_expected.to eql name.to_sym }

    end # describe #name

    describe "#klass" do

      subject { command.klass }

      it { is_expected.to eql klass  }

    end # describe #name

    describe "#converter" do

      subject { command.converter }

      context "by default" do

        let(:command) { described_class.new name, klass }

        it "returns identity function" do
          expect(subject.call).to eql []
          expect(subject.call(:foo, :bar)).to eql [:foo, :bar]
        end

      end # context

      context "initialized" do

        it { is_expected.to eql converter }

      end # context

    end # describe #name

    describe "#call" do

      subject { command.call(*arguments, &block) }

      context "when the klass is not a branch" do

        it "builds a node" do
          expect(klass).to receive(:new) do |*args, &blk|
            expect(args).to eql(converter.call(*arguments))
            expect(blk).to eql block
          end
          subject
        end

      end # context

      context "when the klass is a branch" do

        let(:klass) { Class.new(Branch) }

        it "builds a branch" do
          expect(klass).to receive(:new) do |*args, &blk|
            expect(args).to eql(converter.call(*arguments))
            expect(blk).to be_nil
          end
          subject
        end

      end # context

    end # describe #call

  end # describe AbstractMapper::Command

end # class AbstractMapper