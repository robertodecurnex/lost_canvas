require_relative '../../../../spec_helper'

describe LostCanvas::PNG::Filter::Up do

  describe '::apply' do
    
    it 'should return the filtered scanline' do
    
      LostCanvas::PNG::Filter::Up.apply([1,2,3,4,5,6,7,8,9,10,11,12], [12,11,10,9,8,7,6,5,4,3,2,1]).should == [-11,-9,-7,-5,-3,-1,1,3,5,7,9,11]
      
      LostCanvas::PNG::Filter::Up.apply([1,2,3,4,5,6,7,8,9,10,11,12], []).should == [1,2,3,4,5,6,7,8,9,10,11,12]

    end

  end

  describe '::revert' do
      
    it 'should return the original scanline' do
    
      LostCanvas::PNG::Filter::Up.revert([-11,-9,-7,-5,-3,-1,1,3,5,7,9,11], [12,11,10,9,8,7,6,5,4,3,2,1]).should == [1,2,3,4,5,6,7,8,9,10,11,12]
      
      LostCanvas::PNG::Filter::Up.revert([1,2,3,4,5,6,7,8,9,10,11,12], []).should == [1,2,3,4,5,6,7,8,9,10,11,12]

    end

  end

end
