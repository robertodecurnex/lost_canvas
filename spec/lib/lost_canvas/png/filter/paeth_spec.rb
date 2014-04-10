require_relative '../../../../spec_helper'

describe LostCanvas::PNG::Filter::Paeth do

  describe '::apply' do
    
    it 'should return the scanline untouched' do
    
      LostCanvas::PNG::Filter::Paeth.apply([1,2,3,4,5,6,7,8,9,10,11,12], [12,11,10,9,8,7,6,5,4,3,2,1]).should == [-11,-9,-7,-5,4,4,4,4,5,7,9,7]

    end

  end

  describe '::revert' do
      
    it 'should return the scanline untouched' do
    
      LostCanvas::PNG::Filter::Paeth.revert([-11,-9,-7,-5,4,4,4,4,5,7,9,7], [12,11,10,9,8,7,6,5,4,3,2,1]).should == [1,2,3,4,5,6,7,8,9,10,11,12]

    end

  end

end
