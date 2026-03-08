# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2026-03-07

### Added

#### Commands

- `awssnsalert`, `ctable`, `datamodelsimple`, `dbxquery`, `entitymerge`,
  `fieldformat`, `fieldsummary`, `fromjson`, `ingestpreview`,
  `inputintelligence`, `noop`, `snowevent`, `snoweventstream`,
  `snowincident`, `snowincidentstream` — all verified against the Splunk
  command quick reference and individual command pages

#### Evaluation functions

- `ceil` and `mvreverse` (previously missing from the mathematical and
  multivalue function lists)
- `ctime`, `dur2sec`, `memk`, `mktime`, `mstime`, `rmcomma`, `rmunit` —
  conversion functions used by the `convert` command

#### Statistical / charting functions

- `average` (alias for `avg`)
- `c` (alias for `count`)

#### Built-in fields

- `info_min_time`, `info_max_time`, `info_sid`, `info_search_time` —
  fields added to events by the `addinfo` command

#### Token rules

- `@` tokenized as `Operator` (time snap operator, e.g. `@h`, `@d`)
- `:` tokenized as `Punctuation` (used in values such as `cisco:asa`)
- `{` and `}` tokenized as `Punctuation` (used in `spath` path expressions)
- `$word$` tokenized as `Name::Variable` (macro argument substitution)
- Bare `$` tokenized as `Operator`
- Numeric-suffix rule (`Name::Builtin`) for percentile and trendline
  functions: `perc<N>`, `exactperc<N>`, `upperperc<N>`, `p<N>`,
  `sma<N>`, `ema<N>`, `wma<N>`

### Changed

- Numeric literal patterns no longer include a leading `-`; the minus sign
  is now tokenized separately as an `Operator`, preventing incorrect
  grouping with preceding tokens
- The dot (`.`) operator rule no longer carries a negative lookahead for
  word characters, fixing tokenization of IP addresses such as `10.0.0.*`
- Comparison operator rules split into `[<>!]=|[<>]` and `==` to ensure
  longest-match semantics and avoid partial overlaps
- `exactperc`, `perc`, and `percentile` moved from the `stats_functions`
  set to the numeric-suffix regex rule, where they correctly require a
  numeric argument (e.g. `perc95`, not bare `perc`)

### Removed

- `kv` command — not present in any official Splunk documentation
- `Literal::Date` rule for inline time modifier patterns (e.g. `-24h@h`);
  these are now tokenized as their constituent parts (operator, integer,
  name, snap operator) which is more accurate

## [0.1.0] - 2026-03-05

### Added

- Initial release of the `rouge-lexer-spl` gem
- `Rouge::Lexers::SPL` lexer with tag `spl`, aliases `splunk` and
  `splunk-spl`, filename extensions `.spl` / `.splunk`, and MIME type
  `text/x-spl`
- Auto-detection heuristics based on common SPL patterns
- Token classification for SPL commands, evaluation functions, statistical
  and charting functions, operator keywords, boolean/null constants, and
  built-in internal fields
- Sub-states for block comments (triple backtick), double-quoted strings,
  single-quoted strings, and backtick macro references

[0.2.0]: https://github.com/seanthegeek/rouge-lexer-spl/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/seanthegeek/rouge-lexer-spl/releases/tag/v0.1.0
