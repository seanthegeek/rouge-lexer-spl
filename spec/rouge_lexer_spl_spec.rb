# frozen_string_literal: true

require 'minitest/autorun'
require 'rouge'
require 'rouge/lexer/spl'

class RougeLexerSPLTest < Minitest::Test
  def setup
    @lexer = Rouge::Lexers::SPL.new
  end

  def test_finds_by_tag
    assert_equal Rouge::Lexers::SPL, Rouge::Lexer.find('spl')
  end

  def test_finds_by_alias
    assert_equal Rouge::Lexers::SPL, Rouge::Lexer.find('splunk')
    assert_equal Rouge::Lexers::SPL, Rouge::Lexer.find('splunk-spl')
  end

  def test_guesses_by_filename
    assert_equal Rouge::Lexers::SPL, Rouge::Lexer.guess(filename: 'query.spl')
    assert_equal Rouge::Lexers::SPL, Rouge::Lexer.guess(filename: 'query.splunk')
  end

  def test_guesses_by_mimetype
    assert_equal Rouge::Lexers::SPL, Rouge::Lexer.guess(mimetype: 'text/x-spl')
  end

  def test_demo_preserves_input
    demo = load_demo
    output = @lexer.lex(demo).map { |_, val| val }.join
    assert_equal demo, output, 'Lexer output does not reconstruct the demo input'
  end

  def test_sample_preserves_input
    sample = load_sample
    output = @lexer.lex(sample).map { |_, val| val }.join
    assert_equal sample, output, 'Lexer output does not reconstruct the sample input'
  end

  def test_no_error_tokens_in_demo
    demo = load_demo
    errors = collect_errors(demo)
    assert_empty errors, "Demo produced error tokens:\n#{format_errors(errors)}"
  end

  def test_no_error_tokens_in_sample
    sample = load_sample
    errors = collect_errors(sample)
    assert_empty errors, "Visual sample produced error tokens:\n#{format_errors(errors)}"
  end

  private

  def load_demo
    path = File.join(__dir__, 'demos', 'spl')
    File.read(path)
  end

  def load_sample
    path = File.join(__dir__, 'visual', 'samples', 'spl')
    File.read(path)
  end

  def collect_errors(text)
    @lexer.lex(text).select { |tok, _| tok == Rouge::Token::Tokens::Error }
  end

  def format_errors(errors)
    errors.map { |_, val| "  #{val.inspect}" }.join("\n")
  end
end
