# encoding: utf-8

$LOAD_PATH.unshift 'lib'

require 'lispector/version'

Gem::Specification.new do |s|
  s.name              = 'lispector'
  s.version           = Lispector::VERSION
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = 'Lean lisp dialect'
  s.homepage          = 'http://github.com/fuadsaud/lispector'
  s.email             = 'fuadksd@gmail.com'
  s.authors           = 'Fuad Saud'
  s.has_rdoc          = false

  s.files             = %w( README.md Rakefile LICENSE.md )
  s.files            += Dir.glob('lib/**/*')
  s.files            += Dir.glob('bin/**/*')
  s.files            += Dir.glob('spec/**/*')

  s.executables       = %w( lispector )
  s.description       = <<-DESC
  Feed me.
DESC

  s.add_dependency 'powerpack'

  s.add_development_dependency 'pry'
  s.add_development_dependency 'rspec'
end
