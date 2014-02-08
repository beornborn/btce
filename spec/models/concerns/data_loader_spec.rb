require 'spec_helper'

describe DataLoader do
  context '.load_transactions' do
    let(:time) { Time.at(1315202581) }
    let(:price) { BigDecimal('8.000000000000') }
    let(:amount) { BigDecimal('0.061700000000') }
    
    before do 
      DataLoader.stub(:file_path => "#{Rails.root}/spec/csv/btce.csv")
      DataLoader.load_transactions
    end

    it 'creates needed amount of records; creates valid and correct data' do
      expect(Transaction.count).to eq(1050)

      transaction = Transaction.first
      
      expect(transaction.time).to be_a(Time)
      expect(transaction.price).to be_a(BigDecimal)
      expect(transaction.amount).to be_a(BigDecimal)
      
      expect(transaction.time).to eq(time)
      expect(transaction.price).to eq(price)
      expect(transaction.amount).to eq(amount)
    end 
  end

  context '.load_minutes' do
    before do
      @time1 = Time.new(2012, 1, 1, 9, 0, 0)
      Fabricate :transaction, time: @time1, amount: 5, price: 3 
      Fabricate :transaction, time: @time1 + 1.second, amount: 5, price: 10 
      Fabricate :transaction, time: @time1 + 2.second, amount: 5, price: 25 
      
      @time2 = Time.new(2012, 1, 1, 9, 1, 0)

      @time3 = Time.new(2012, 1, 1, 9, 2, 0)
      Fabricate :transaction, time: @time3, amount: 2, price: 15 
      Fabricate :transaction, time: @time3 + 1.second, amount: 2, price: 10 
      Fabricate :transaction, time: @time3 + 2.second, amount: 2, price: 100 
      Fabricate :transaction, time: @time3 + 3.second, amount: 2, price: 50 

      DataLoader.load_minutes
    end

    it 'creates correct amount of minutes' do
      expect(Minute.count).to eq(3)
    end

    it 'creates correct minutes' do
      minute = Minute.first
      expect(minute.time).to be_a(Time)
      expect(minute.enter).to be_a(BigDecimal)
      expect(minute.close).to be_a(BigDecimal)
      expect(minute.min).to be_a(BigDecimal)
      expect(minute.max).to be_a(BigDecimal)
      expect(minute.amount).to be_a(BigDecimal)

      minute = Minute.find_by(time: @time1)
      expect(minute.amount).to eq(15)
      expect(minute.enter).to eq(3)
      expect(minute.close).to eq(25)
      expect(minute.min).to eq(3)
      expect(minute.max).to eq(25)
      
      minute = Minute.find_by(time: @time2)
      expect(minute.amount).to eq(0)
      expect(minute.enter).to eq(25)
      expect(minute.close).to eq(25)
      expect(minute.min).to eq(25)
      expect(minute.max).to eq(25)
      
      minute = Minute.find_by(time: @time3)
      expect(minute.amount).to eq(8)
      expect(minute.enter).to eq(15)
      expect(minute.close).to eq(50)
      expect(minute.min).to eq(10)
      expect(minute.max).to eq(100)
    end
  end
end