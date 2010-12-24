Gem::Specification.new do |spec|
  spec.name = 'swatch'
  spec.author = 'Matthieu Maury'
  spec.email = 'mayeu.tik@gmail.com'
  spec.homepage = 'http://github.com/Mayeutik/swatch'
  spec.version = '0.2'
  spec.summary = 'A simple cli timetracking script that can be use with todo.txt'
  spec.description = <<-EOF
Swatch is a simple timetracking script in Ruby.
It can be used in conjonction of the todo.txt script
EOF
  spec.require_path = 'lib'
  spec.files = Dir['lib/*']
  spec.files << 'README.rdoc'
  spec.files << 'CHANGELOG.rdoc'
  spec.files << 'LICENSE'
  spec.executables << 'swatch'
end
