require 'rspec'

describe 'my_uniq' do

    it 'works on the given test to return an array of unique elements' do
        expect([1, 2, 1, 3, 3].my_uniq).to eq([1, 2, 3])
    end
    it 'makes an arrays elements unique' do
        expect([1,1,1,1,1,2,3,3,3,3,3,3,3,4,4,4,4,5].my_uniq).to eq([1,1,1,1,1,2,3,3,3,3,3,3,3,4,4,4,4,5].uniq)
    end
    it 'also uniques strings within an array' do
        expect(['a','blue', 'blue', 'blue', 'a', 'sixty-two', 'sixty-two', 'sixty-two', 'blue'].my_uniq).to eq(['a','blue', 'blue', 'blue', 'a', 'sixty-two', 'sixty-two', 'sixty-two', 'blue'].uniq)
    end
    it 'also works on mixed data types in an array' do
        expect([1,'one',11,1,111,'one',11,1,1].my_uniq).to eq([1,'one',11,1,111,'one',11,1,1].uniq)
    end
    it 'is not thrown off by capital letters' do
        expect(['five', 4, 'Three', 'BLUE', 'blue', 'BluE'].my_uniq).to eq(['five', 4, 'Three', 'BLUE', 'blue', 'BluE'].uniq)
    end
    it 'works on larger integers as well' do
        expect([513549876513,654654687984654,654651213541687,513549876513,654651213541687,987948531546897,513549876513,654651213541687,6549841354987651].my_uniq).to eq([513549876513,654654687984654,654651213541687,513549876513,654651213541687,987948531546897,513549876513,654651213541687,6549841354987651].uniq)
    end
    it 'returns elements in the order in which they were given' do
        expect([7,16,1,7,7,7,1,1,1].my_uniq).to eq([7,16,1])
    end
    it 'throws an error if used on anything other than an array' do
        expect('not an array'.my_uniq).to raise_error(TypeError)
    end

end

describe 'two_sum' do
    
    it 'passes the given test' do
        expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
    end
    it 'finds all pairs of positions where the elements at those positions sum to zero' do
        expect([3,-6,0,5,78,55,6,-78].two_sum).to eq([[1,6],[4,7]])
    end
    it 'pairs to be sorted smaller index before bigger index' do
        expect([1,2,3,-2,3,-1].two_sum).to eq([[0,5],[1,3]])
    end
    it 'pairs to be sorted "dictionary-wise"' do
        expect([-99,99,-1,2,1,-16,4,16].two_sum).to eq([[0,1],[2,4],[5,7]])
    end
    it 'smaller first elements come first, then smaller second elements come first' do
        expect([-3,9,7,-9,3].two_sum).to eq([[0,4],[1,3]])
    end

end

describe 'my_transpose' do

    it 'passes the given test case' do
        expect(my_transpose([[0, 1, 2],
                             [3, 4, 5],
                             [6, 7, 8]])).to eq([[0, 3, 6],
                                                [1, 4, 7],
                                                [2, 5, 8]])
    end
    it 'converts between the row-oriented and column-oriented representations' do
        expect(my_transpose([['a','b','c'],
                             ['d','e','f'],
                             ['g','h','i']])).to eq([['a','d','g'],
                                                     ['b','e','h'],
                                                     ['c','f','i']])
    end
    it 'throws an error when given anything but an array of arrays' do
        expect { my_transpose(['not an array of arrays']) }.to raise_error(TypeError)
    end
end

describe 'stock_picker' do
    
end