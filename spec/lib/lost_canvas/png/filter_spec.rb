require_relative '../../../spec_helper'

describe LostCanvas::PNG::Filter do

  describe '::get' do

    it 'should return the filter class for the given type' do
      LostCanvas::PNG::Filter.get(0).should == LostCanvas::PNG::Filter::None
      LostCanvas::PNG::Filter.get(1).should == LostCanvas::PNG::Filter::Sub
      LostCanvas::PNG::Filter.get(2).should == LostCanvas::PNG::Filter::Up
      LostCanvas::PNG::Filter.get(3).should == LostCanvas::PNG::Filter::Average
      LostCanvas::PNG::Filter.get(4).should == LostCanvas::PNG::Filter::Paeth
    end

  end

end
