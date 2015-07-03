# encoding: utf-8

require "abstract_mapper/rspec"

describe AbstractMapper::Functions, "#compact" do

  let(:function)  { -> a, b { (a == b) ? [a + b] : [a, b] } }
  let(:arguments) { [:compact, function] }

  it_behaves_like :transforming_immutable_data do
    let(:input)  { [] }
    let(:output) { [] }
  end

  it_behaves_like :transforming_immutable_data do
    let(:input)  { [1] }
    let(:output) { [1] }
  end

  it_behaves_like :transforming_immutable_data do
    let(:input)  { [1, 1, 2, 3, 3] }
    let(:output) { [4, 6]          }
  end

end # describe AbstractMapper::Functions#compact
