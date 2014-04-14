require_relative '../../../../spec_helper'

describe LostCanvas::PNG::Filter::Average do

  describe '#apply' do
    
    it 'should return the filtered scanline' do
    
      LostCanvas::PNG::Filter::Average.new(6).apply([1,2,3,4,5,6,7,8,9,10,11,12], [12,11,10,9,8,7,6,5,4,3,2,1]).should == [-5,-3,-2,0,1,2,3,4,5,6,7,8]

      LostCanvas::PNG::Filter::Average.new(6).apply([1,2,3,4,5,6,7,8,9,10,11,12], []).should == [1,2,3,4,5,5,6,6,7,7,8,8]

    end

  end

  describe '#revert' do
      
    it 'should return the original scanline' do
    
      LostCanvas::PNG::Filter::Average.new(6).revert([-5,-3,-2,0,1,2,3,4,5,6,7,8], [12,11,10,9,8,7,6,5,4,3,2,1]).should == [1,2,3,4,5,6,7,8,9,10,11,12]

      LostCanvas::PNG::Filter::Average.new(6).revert([1,2,3,4,5,5,6,6,7,7,8,8], []).should == [1,2,3,4,5,6,7,8,9,10,11,12]

    end

  end

end
