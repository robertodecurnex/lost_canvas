require_relative '../../../../spec_helper'

describe LostCanvas::PNG::Filter::Sub do

  describe '::apply' do
    
    it 'should return the filtered scanline' do
    
      LostCanvas::PNG::Filter::Sub.apply([1,2,3,4,5,6,7,8,9,10,11,12], [12,11,10,9,8,7,6,5,4,3,2,1]).should == [1,2,3,4,4,4,4,4,4,4,4,4]
      
      LostCanvas::PNG::Filter::Sub.apply([1,2,3,4,5,6,7,8,9,10,11,12], []).should == [1,2,3,4,4,4,4,4,4,4,4,4]

    end

  end

  describe '::revert' do
      
    it 'should return the original scanline' do
    
      LostCanvas::PNG::Filter::Sub.revert([1,2,3,4,4,4,4,4,4,4,4,4], [12,11,10,9,8,7,6,5,4,3,2,1]).should == [1,2,3,4,5,6,7,8,9,10,11,12]
      
      LostCanvas::PNG::Filter::Sub.revert([1,2,3,4,4,4,4,4,4,4,4,4], []).should == [1,2,3,4,5,6,7,8,9,10,11,12]

    end

  end

end
