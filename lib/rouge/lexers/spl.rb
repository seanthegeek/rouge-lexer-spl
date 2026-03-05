# frozen_string_literal: true

module Rouge
  module Lexers
    class SPL < RegexLexer
      title 'SPL'
      desc 'Splunk Search Processing Language (SPL)'
      tag 'spl'
      aliases 'splunk', 'splunk-spl'
      filenames '*.spl', '*.splunk'
      mimetypes 'text/x-spl'

      # TODO: Paste full lexer implementation here
      state :root do
        rule(/\s+/, Text)
        rule(/./, Text)
      end
    end
  end
end
