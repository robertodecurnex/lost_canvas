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
  ]

  specification.files = [
    'LICENSE',
    'lost_canvas.gemspec',
    'lib/lost_canvas.rb',
    'lib/lost_canvas/png.rb',
    'lib/lost_canvas/png/chunk.rb'
  ] + specification.test_files
  
  specification.required_ruby_version = '>=2.1'

  specification.add_development_dependency 'rake'
  specification.add_development_dependency 'rspec'
end 
