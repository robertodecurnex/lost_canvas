require_relative '../../spec_helper'

describe LostCanvas::Image do
 
  let :image1x1 do
    LostCanvas::Image.open('./spec/files/1x1_black.png')
  end
  
  let :image2x2 do
    LostCanvas::Image.open('./spec/files/2x2_black.png')
  end
 
  describe '::open' do

    it 'should return a LostCanvas::Image instance' do
      image1x1.class.should be LostCanvas::Image
    end

  end

  describe '#encoding.format' do
    
    it 'should return png' do
      image1x1.encoding.format.should == 'png'
      image2x2.encoding.format.should == 'png'
    end

  end

  describe '#height' do

    it 'should return the image height' do
      image1x1.heigth.should == 1
      image2x2.heigth.should == 2
    end

  end

  describe '#save' do

    it 'should return true' do
      image1x1.save.should == true
    end

  end

  describe '#width' do
    
    it 'should retunrn the image width' do
      image1x1.width.should == 1
      image2x2.width.should == 2
    end

  end

 

end
