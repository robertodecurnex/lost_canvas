require_relative '../../spec_helper'

describe LostCanvas::Image do
 
  before :each do
    @image = LostCanvas::Image.open('./spec/files/1x1_black.png')
  end
 
  describe '#open' do

    it 'should return a LostCanvas::Image instance' do
      @image.class.should be LostCanvas::Image
    end

  end

  describe '#save' do

    it 'should return true' do
      @image.save.should == true
    end

  end

  describe '#heigth' do

    it 'should return 1' do
      @image.heigth.should == 1
    end

  end

  describe '#width' do
    
    it 'should retunrn 1' do
      @image.width.should == 1
    end

  end

end
