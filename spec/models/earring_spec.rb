# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Earring, type: :model do
  # Test the Earring model
  # Test earring number validations
  it 'has a valid factory' do
    earring = FactoryBot.build(:earring)
    expect(earring).to be_valid
  end

  describe 'earring number validations' do
    context 'valid cases' do
      it 'accepts valid 4-digit earring numbers' do
        [1000, 9999].each do |valid_number|
          earring = FactoryBot.build(:earring, earring: valid_number)
          expect(earring).to be_valid
        end
      end
    end

    context 'invalid cases' do
      invalid_cases = {
        nil => 'no puede estar en blanco',
        'abcd' => 'no es un número',
        -1234 => 'debe ser mayor que o igual a 0',
        123 => 'no es válido',
        12_345 => 'no es válido',
        0 => 'no es válido',
        1234.5 => 'debe ser un entero'
      }
      invalid_cases.each do |invalid_value, error_message|
        it "rejects invalid earring number: #{invalid_value}" do
          earring = FactoryBot.build(:earring, earring: invalid_value)
          expect(earring).not_to be_valid
          expect(earring.errors[:earring]).to include(error_message)
        end
      end
    end
  end

  it 'is unique for earring number' do
    FactoryBot.create(:earring, earring: 1234)
    earring2 = FactoryBot.build(:earring, earring: 1234)
    expect(earring2).not_to be_valid
    expect(earring2.errors[:earring]).to include('ya está en uso')
  end

  # Test age validations
  describe 'age validations' do
    context 'valid cases' do
      it 'accepts valid positive integer ages' do
        [1, 10, 9998].each do |valid_age|
          earring = FactoryBot.build(:earring, age: valid_age)
          expect(earring).to be_valid
        end
      end
    end

    context 'invalid cases' do
      invalid_cases = {
        -1 => 'debe ser mayor que 0',
        0 => 'debe ser mayor que 0',
        2.5 => 'debe ser un entero',
        'five' => 'no es un número',
        12_345 => 'debe ser menor que 9999'
      }
      invalid_cases.each do |invalid_value, error_message|
        it "rejects invalid age: #{invalid_value}" do
          earring = FactoryBot.build(:earring, age: invalid_value)
          expect(earring).not_to be_valid
          expect(earring.errors[:age]).to include(error_message)
        end
      end
    end
  end

  # Test gender validations
  describe 'gender validations' do
    context 'valid cases' do
      it 'accepts valid number string or symbol values' do
        ['male', 'female', :male, :female, 0, 1].each do |valid_gender|
          earring = FactoryBot.build(:earring, gender: valid_gender)
          expect(earring).to be_valid
        end
      end
    end
    context 'invalid cases' do
      it 'rejects nil gender' do
        earring = FactoryBot.build(:earring, gender: nil)
        expect(earring).not_to be_valid
        expect(earring.errors[:gender]).to include('no puede estar en blanco')
      end

      ['unknown', 2].each do |invalid_value|
        it "raises ArgumentError for invalid gender: #{invalid_value.inspect}" do
          expect do
            FactoryBot.build(:earring, gender: invalid_value)
          end.to raise_error(ArgumentError)
        end
      end
    end

    it 'defines expected enum values' do
      expect(Earring.genders.keys).to match_array(%w[male female])
    end
  end

  # Test status validations
  describe 'status validations' do
    context 'valid cases' do
      it 'accepts valid status values' do
        [:live, :dead, :sold, 'live', 'dead', 'sold', 0, 1, 2].each do |valid_status|
          earring = FactoryBot.build(:earring, status: valid_status)
          expect(earring).to be_valid
        end
      end
    end

    context 'invalid cases' do
      it 'rejects nil status' do
        earring = FactoryBot.build(:earring, status: nil)
        expect(earring).not_to be_valid
        expect(earring.errors[:status]).to include('no puede estar en blanco')
      end

      ['unknown', 3].each do |invalid_value|
        it "raises ArgumentError for invalid status: #{invalid_value.inspect}" do
          expect do
            FactoryBot.build(:earring, status: invalid_value)
          end.to raise_error(ArgumentError)
        end
      end
    end

    it 'defines expected enum values' do
      expect(Earring.statuses.keys).to match_array(%w[live dead sold])
    end
  end

  # Test key_id validations
  describe 'key association validations' do
    let(:valid_key) { FactoryBot.create(:key) }

    it 'is valid with an existing key' do
      earring = FactoryBot.build(:earring, key: valid_key)
      expect(earring).to be_valid
    end

    context 'with invalid key association' do
      invalid_cases = {
        nil => 'debe existir',
        -1 => 'debe existir',
        'abcd' => 'debe existir',
        12_345 => 'debe existir'
      }

      invalid_cases.each do |invalid_value, error_message|
        it "rejects invalid key_id: #{invalid_value.inspect}" do
          earring = FactoryBot.build(:earring, key_id: invalid_value)
          expect(earring).not_to be_valid
          expect(earring.errors[:key]).to include(error_message)

          # Verificación adicional para asegurar que no se crea relación
          expect(earring.key).to be_nil
        end
      end
    end
  end
end
