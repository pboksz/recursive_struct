require 'spec_helper'

describe RecursiveStruct do
  let(:hash) { nil }
  subject { RecursiveStruct.new(hash) }

  describe 'hash is nil' do
    it { expect(subject).to be_a RecursiveStruct }
  end

  describe 'hash exists' do
    let(:hash) { { one: true } }
    it { expect(subject.one).to be true }
  end

  describe 'nested hash' do
    let(:hash) { { one: { two: true } } }
    it { expect(subject.one).to be_a RecursiveStruct }
    it { expect(subject.one.two).to be true }
  end

  describe 'hash with array' do
    let(:hash) { { one: [1, 2, 3] } }
    it { expect(subject.one).to be_an Array }
    it { expect(subject.one).not_to be_empty }
  end

  describe 'hash with array of hashes' do
    let(:hash) { { one: [{ two: true }] } }
    it { expect(subject.one.first).to be_a RecursiveStruct }
    it { expect(subject.one.first.two).to be true }
  end

  describe 'proper setter is created' do
    let(:hash) { { one: { two: true } } }

    describe 'nested setter' do
      before { subject.one.two = false }
      it { expect(subject.one.two).to be false }
    end

    describe 'top level setter' do
      before { subject.one = false }
      it { expect(subject.one).to be false }
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

  describe '#method_missing' do
    describe 'valid setter' do
      describe 'single value' do
        before { subject.one = true }
        it { expect(subject.one).to be true }
      end

      describe 'hash setter' do
        before { subject[:one] = true }
        it { expect(subject[:one]).to be true }
        it { expect(subject.one).to be true }
      end

      describe 'array value' do
        before { subject.one = [1, 2] }
        it { expect(subject.one).not_to be_empty }
      end

      describe 'hash value' do
        before { subject.one = { two: true } }
        it { expect(subject.one.two).to eq true }
      end
    end

    describe 'invalid getter' do
      it { expect(subject.one).to be_nil }
    end

    describe 'invalid method' do
      it { expect { subject.one(1) }.to raise_error NoMethodError }
    end

    describe 'responds to hash methods' do
      it { expect { subject.keys }.not_to raise_error }
    end
  end
end
