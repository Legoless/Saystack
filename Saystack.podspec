Pod::Spec.new do |s|

  s.name         = "Saystack"
  s.version      = "0.6.3"
  s.summary      = "A collection of simple iOS classes and categories that fit in almost every project."

  s.description  = <<-DESC
                   Saystack contains a collection of simple iOS classes and small libraries that fit in almost every project. Most of these classes are not large or structured enough to fit in a special library or framework, but are regurarely needed throughout the most projects you are working on.
                   DESC

  s.homepage     = "http://github.com/Legoless/Saystack"
  s.license      = 'MIT'
  s.author       = { "Dal Rupnik" => "legoless@gmail.com" }
  s.ios.deployment_target     = '9.0'
  s.ios.source_files = 'Code/Extensions/**/*.{swift}'
  s.osx.deployment_target     = '10.11'
  s.osx.source_files = 'Code/Extensions/Core/**/*.{swift}'
  s.source       = { :git => "https://github.com/Legoless/Saystack.git", :tag => s.version }
  
  s.requires_arc = true
end
