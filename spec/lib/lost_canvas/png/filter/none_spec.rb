require_relative '../../../../spec_helper'

describe LostCanvas::PNG::Filter::None do

  describe '::apply' do
    
    describe 'with previous scanline' do

      it 'should return the scanline untouched' do
      
         LostCanvas::PNG::Filter::None.new(6).apply([1,2,3,4,5,6,7,8,9,10,11,12], [1,2,3,4,5,6,7,8,9,10,11,12]).should == [1,2,3,4,5,6,7,8,9,10,11,12]

      end

    end

    describe 'without previous scanline' do
      
      it 'should return the scanline untouched' do
      
         LostCanvas::PNG::Filter::None.new(6).apply([1,2,3,4,5,6,7,8,9,10,11,12]).should == [1,2,3,4,5,6,7,8,9,10,11,12]

      end

    end

  end

  describe '::revert' do
    
    describe 'with previous scanline' do
      
      it 'should return the scanline untouched' do
      
         LostCanvas::PNG::Filter::None.new(6).revert([1,2,3,4,5,6,7,8,9,10,11,12], [1,2,3,4,5,6,7,8,9,10,11,12]).should == [1,2,3,4,5,6,7,8,9,10,11,12]

      end

    end

    describe 'without previous scanline' do
      
      it 'should return the scanline untouched' do
      
         LostCanvas::PNG::Filter::None.new(6).revert([1,2,3,4,5,6,7,8,9,10,11,12]).should == [1,2,3,4,5,6,7,8,9,10,11,12]

      end

    end

  end

end
