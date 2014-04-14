require_relative '../../../spec_helper'

describe LostCanvas::PNG::Filter do

  describe '::get' do

    it 'should return the filter class for the given type' do
      LostCanvas::PNG::Filter.get(0,6).should be_instance_of LostCanvas::PNG::Filter::None
      LostCanvas::PNG::Filter.get(1,6).should be_instance_of LostCanvas::PNG::Filter::Sub
      LostCanvas::PNG::Filter.get(2,6).should be_instance_of LostCanvas::PNG::Filter::Up
      LostCanvas::PNG::Filter.get(3,6).should be_instance_of LostCanvas::PNG::Filter::Average
      LostCanvas::PNG::Filter.get(4,6).should be_instance_of LostCanvas::PNG::Filter::Paeth
    end

  end

end
