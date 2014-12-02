require 'spec_helper'

describe RecursiveStruct do
  subject { RecursiveStruct.new(hash) }

  describe 'hash is nil' do
    let(:hash) { nil }
    it { expect(subject).to be_a RecursiveStruct }
  end

  describe 'hash exists' do
    let(:hash) { { one: true } }
    it { expect(subject.one).to be_true }
  end

  describe 'nested hash' do
    let(:hash) { { one: { two: true } } }
    it { expect(subject.one.two).to be_true }
  end

  describe 'hash with array' do
    let(:hash) { { one: { two: [1, 2, 3] } } }
    it { expect(subject.one.two).not_to be_empty }
  end

  describe 'proper setter is created' do
    let(:hash) { { one: { two: true } } }

    describe 'nested setter' do
      before { subject.one.two = false }
      it { expect(subject.one.two).to be_false }
    end

    describe 'top level setter' do
      before { subject.one = false }
      it { expect(subject.one).to be_false }
    end

    describe 'setting a hash' do
      before { subject.one = { two: true } }
      it { expect(subject.one).to be_a Hash }
    end

    describe 'setting an array' do
      before { subject.one = [1, 2] }
      it { expect(subject.one).to be_an Array }
    end
  end
end