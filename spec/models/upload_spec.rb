require 'rails_helper'

RSpec.describe Upload do
  describe 'validations' do
    it { should validate_presence_of :file }
  end

  describe '#assign_attributes' do
    it 'assigns hash values to key methods' do
      expect { subject.assign_attributes(file: 'foo') }.to change { subject.file }.to('foo')
    end

    it 'does not raise if passed nil' do
      expect { subject.assign_attributes(nil) }.to_not raise_error
    end

    it 'raises is passed invalid keys' do
      expect { subject.assign_attributes(a: :a) }.to raise_error
    end
  end

  describe '#save' do
    subject { described_class.new(file: file) }

    describe 'when the model is valid' do
      let(:file) { fixture_file(filename, Mime::CSV.to_s) }

      describe 'and the file is properly formatted' do
        let(:filename) { 'imports/sample1.csv' }

        it 'returns true' do
          expect(subject.save).to be true
        end

        it 'assigns the revenue result value' do
          expect { subject.save }.to change { subject.revenue }.to(95.0)
        end
      end

      describe 'and the file is improperly formatted' do
        let(:filename) { 'imports/invalid.csv' }

        it 'returns false' do
          expect(subject.save).to be false
        end

        it 'does not assign the revenue result value' do
          expect { subject.save }.to_not change { subject.revenue }
        end

        it 'adds an error to the model field' do
          expect { subject.save }.to change { subject.errors[:file] }.to(['must be a properly formatted CSV file'])
        end
      end
    end

    describe 'when the model is invalid' do
      let(:file) { nil }

      it 'returns false' do
        expect(subject.save).to be false
      end

      it 'does not assign the revenue result value' do
        expect { subject.save }.to_not change { subject.revenue }
      end
    end
  end
end
