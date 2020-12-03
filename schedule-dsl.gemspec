Gem::Specification.new do |spec|
  spec.name = 'schedule-dsl'
  spec.version = '0.0.1'
  spec.license = 'MIT' # Just so gem build would shut up. Use it however you like.

  spec.summary = "Provides a DSL for defining your schedule rules and getting results for given date."
  spec.author = "Jakub Šťastný"
  spec.homepage = 'https://github.com/jakub-stastny/schedule-dsl'

  spec.files = Dir["{lib,spec}/**/*.rb"] + ['Gemfile', 'Gemfile.lock', 'README.md', 'schedule-dsl.gemspec']
end
