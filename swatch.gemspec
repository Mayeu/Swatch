Gem::Specification.new do |spec|
  spec.name = 'swatch'
  spec.author = 'Matthieu Maury'
  spec.email = 'mayeu.tik@gmail.com'
  spec.version = 'Alpha'
  spec.summary = 'A simple cli timetracking script that can be use with todo.txt'
  spec.require_path = 'lib'
  spec.files = Dir['lib/*']
  spec.files << 'README.rdoc'
  #spec.files << 'CHANGELOG.rdoc'
  spec.files << 'LICENSE'
  spec.executables << 'condom'
end
