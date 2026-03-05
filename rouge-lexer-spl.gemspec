# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name        = 'rouge-lexer-spl'
  s.version     = '0.1.0'
  s.summary     = 'Rouge lexer for Splunk SPL'
  s.description = 'A Rouge plugin providing syntax highlighting for ' \
                  'Splunk Search Processing Language (SPL)'
  s.authors     = ['Sean Whalen']
  s.homepage    = 'https://github.com/seanthegeek/rouge-lexer-spl'
  s.license     = 'MIT'
  s.files       = Dir['lib/**/*.rb'] + Dir['spec/demos/*'] + Dir['spec/visual/samples/*']

  s.required_ruby_version = '>= 3.0'

  s.add_dependency 'rouge', '>= 3.0'

  s.metadata = {
    'source_code_uri' => 'https://github.com/seanthegeek/rouge-lexer-spl',
    'bug_tracker_uri' => 'https://github.com/seanthegeek/rouge-lexer-spl/issues'
  }
end
