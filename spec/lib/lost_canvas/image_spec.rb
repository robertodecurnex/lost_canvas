require_relative '../../spec_helper'

describe LostCanvas::Image do
 
  let :image1x1 do
    LostCanvas::Image.open('./spec/files/1x1_black_no_filter.png')
  end
  
  let :image2x2 do
    LostCanvas::Image.open('./spec/files/2x2_black_sub_filter.png')
  end
 
  describe '::open' do

    it 'should return a LostCanvas::Image instance' do
      image1x1.class.should be LostCanvas::Image
    end

  end

  describe '#encoding' do
    
    describe '#format' do
    
      it 'should return png' do
        image1x1.encoding.format.should == 'png'
        image2x2.encoding.format.should == 'png'
      end

    end

    describe '#bit_depth' do
    
      it 'should return 8' do
        image1x1.encoding.bit_depth.should == 8
        image2x2.encoding.bit_depth.should == 8
      end

    end
    
    describe '#color_type' do
    
      it 'should return 6' do
        image1x1.encoding.color_type.should == 6
        image2x2.encoding.color_type.should == 6
      end

    end
    
    describe '#compression_method' do
    
      it 'should return 0' do
        image1x1.encoding.compression_method.should == 0
        image2x2.encoding.compression_method.should == 0
      end

    end

    describe '#filter_method' do
    
      it 'should return 0' do
        image1x1.encoding.filter_method.should == 0
        image2x2.encoding.filter_method.should == 0
      end

    end

    describe '#interlace_method' do
    
      it 'should return 0' do
        image1x1.encoding.interlace_method.should == 0
        image2x2.encoding.interlace_method.should == 0
      end

    end

    describe '#height' do
    
      it 'should return the image height' do
        image1x1.encoding.height.should == 1
        image2x2.encoding.height.should == 2
      end

    end

    describe '#width' do
    
      it 'should return the image width' do
        image1x1.encoding.width.should == 1
        image2x2.encoding.width.should == 2
      end

    end

  end

  describe '#height' do

    it 'should return the image height' do
      image1x1.heigth.should == 1
      image2x2.heigth.should == 2
    end

  end

  describe '#pixels' do

    it 'should return a Matrix instance' do
      image1x1.pixels.class.should == Matrix
      image2x2.pixels.class.should == Matrix
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
