require 'rspec'

describe 'my_uniq' do
    arr = [1,2,2,3,3,3,4,4,5]
    it 'makes an arrays elements unique' do
        expect(arr.my_uniq).to eq(arr.uniq)
    end
end

describe 'two_sum' do
    
end

describe 'my_transpose' do
    
end

describe 'stock_picker' do
    
end