# encoding: utf-8

require_relative 'lib/lost_canvas/version'

Gem::Specification.new do |specification|
  specification.name = 'lost_canvas'
  specification.version = LostCanvas::VERSION
  specification.summary = 'Ruby Image Processing Library'
  specification.description = <<-DESCRIPTION
    Create, open, edit and update images without system dependencies.   
  DESCRIPTION
  specification.authors = ['Franco Castellacci', 'Roberto Decurnex']
  specification.email = ['castellacci.franco@gmail.com', 'decurnex.roberto@gmail.com']
  specification.homepage = 'http://github.com/lost-canvas/lost_canvas'
  specification.license = 'MIT'
 
  specification.test_files = [
    'spec/files/1x1_black_no_filter.png',
    'spec/files/2x2_black_sub_up_filter.png',
    'spec/files/2x2_black_sub_up_filter_grayscale.png',
    'spec/lib/lost_canvas/png/filter/average_spec.rb',
    'spec/lib/lost_canvas/png/filter/none_spec.rb',
    'spec/lib/lost_canvas/png/filter/paeth_spec.rb',
    'spec/lib/lost_canvas/png/filter/sub_spec-rb',
    'spec/lib/lost_canvas/png/filter/up_spec.rb',
    'spec/lib/lost_canvas/png/filter_spec.rb',
    'spec/lib/lost_canvas/image_spec',
    'spec_helper.rb'
  ]

  specification.files = [
    'LICENSE',
    'lost_canvas.gemspec',
    'lib/lost_canvas.rb',
    'lib/lost_canvas/png.rb',
    'lib/lost_canvas/png/chunk.rb'
  ] + specification.test_files
  
  specification.required_ruby_version = '>=2'

  specification.add_development_dependency 'coveralls'
  specification.add_development_dependency 'rake'
  specification.add_development_dependency 'rspec'
end 
