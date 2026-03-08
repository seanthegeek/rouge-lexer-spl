# -*- coding: utf-8 -*- #
# frozen_string_literal: true

module Rouge
  module Lexers
    class SPL < RegexLexer
      title "SPL"
      desc "Splunk Search Processing Language (SPL)"
      tag 'spl'
      aliases 'splunk', 'splunk-spl'
      filenames '*.spl', '*.splunk'
      mimetypes 'text/x-spl'

      def self.detect?(text)
        return true if text =~ /^\s*\|\s*(stats|eval|table|search|where|rex|rename|fields|sort|dedup|timechart|chart|head|tail)\b/i
        return true if text =~ /\bindex\s*=\s*\w+/i && text =~ /\bsourcetype\s*=\s*/i
      end

      # SPL commands
      # Source: https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/quick-reference/command-quick-reference
      def self.commands
        @commands ||= Set.new %w(
          abstract accum addcoltotals addinfo addtotals analyzefields
          anomalies anomalousvalue anomalydetection append appendcols
          appendpipe arules associate autoregress awssnsalert bin bucket
          bucketdir chart cluster cofilter collect concurrency contingency
          convert correlate ctable datamodel datamodelsimple dbinspect
          dbxquery dedup delete delta diff entitymerge erex eval eventcount
          eventstats extract fieldformat fields fieldsummary filldown
          fillnull findtypes folderize foreach format from fromjson gauge
          gentimes geom geomfilter geostats head highlight history iconify
          ingestpreview inputcsv inputintelligence inputlookup iplocation
          join kmeans kvform loadjob localize localop lookup makecontinuous
          makemv makeresults map mcollect metadata metasearch meventcollect
          mpreview msearch mstats multikv multisearch mvcombine mvexpand
          nomv outlier outputcsv outputlookup outputtext overlap pivot
          predict rangemap rare redistribute regex reltime rename replace
          require rest return reverse rex rtorder run savedsearch script
          scrub search searchtxn selfjoin sendalert sendemail set setfields
          sichart sirare sistats sitimechart sitop snowevent snoweventstream
          snowincident snowincidentstream sort spath stats strcat
          streamstats table tags tail timechart timewrap tojson top
          transaction transpose trendline tscollect tstats typeahead
          typelearner typer union uniq untable walklex where x11 xmlkv
          xmlunescape xpath xyseries
        )
      end

      # Evaluation functions
      # Sources:
      #   Bitwise:        https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/evaluation-functions/bitwise-functions
      #   Comparison:     https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/evaluation-functions/comparison-and-conditional-functions
      #   Conversion:     https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/evaluation-functions/conversion-functions
      #   Cryptographic:  https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/evaluation-functions/cryptographic-functions
      #   Date/Time:      https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/evaluation-functions/date-and-time-functions
      #   Informational:  https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/evaluation-functions/informational-functions
      #   JSON:           https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/evaluation-functions/json-functions
      #   Mathematical:   https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/evaluation-functions/mathematical-functions
      #   Multivalue:     https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/evaluation-functions/multivalue-eval-functions
      #   Statistical:    https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/evaluation-functions/statistical-eval-functions
      #   Text:           https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/evaluation-functions/text-functions
      #   Trig:           https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/evaluation-functions/trig-and-hyperbolic-functions
      def self.eval_functions
        @eval_functions ||= Set.new %w(
          abs acos acosh asin asinh atan atan2 atanh avg
          bit_and bit_not bit_or bit_shift_left bit_shift_right bit_xor
          case ceiling cidrmatch coalesce commands cos cosh
          exact exp false floor hypot if ipmask
          isarray isbool isdouble isint ismv isnotnull isnull isnum isobject isstr
          json json_append json_array json_array_to_mv json_delete json_entries
          json_extend json_extract json_extract_exact json_has_key_exact
          json_keys json_object json_set json_set_exact json_valid
          len like ln log lower ltrim match max md5 min
          mv_to_json_array mvappend mvcount mvdedup mvfilter mvfind mvindex
          mvjoin mvmap mvrange mvsort mvzip
          now null nullif pi pow printf random relative_time replace round
          rtrim searchmatch sha1 sha256 sha512 sigfig sin sinh split sqrt
          spath strftime strptime substr sum tan tanh time toarray tobool
          todouble toint tomv tonumber toobject tostring trim true typeof
          upper urldecode validate
        )
      end

      # Statistical and charting functions
      # Sources:
      #   Aggregate:   https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/statistical-and-charting-functions/aggregate-functions
      #   Event order: https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/statistical-and-charting-functions/event-order-functions
      #   Multivalue:  https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/statistical-and-charting-functions/multivalue-stats-and-chart-functions
      #   Time:        https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/statistical-and-charting-functions/time-functions
      def self.stats_functions
        @stats_functions ||= Set.new %w(
          avg c count dc distinct_count earliest earliest_time estdc estdc_error
          first last latest latest_time list max mean median min mode
          per_day per_hour per_minute per_second range rate rate_avg rate_sum
          stdev stdevp sum sumsq upperperc values var varp
        )
      end

      # Operator keywords
      # Source: https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/introduction/understanding-spl-syntax
      #         https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/search-commands/replace
      #         https://help.splunk.com/en/splunk-enterprise/search/spl-search-reference/10.2/search-commands/lookup
      def self.operator_words
        @operator_words ||= Set.new %w(
          AND AS BY IN LIKE NOT OR OUTPUT OUTPUTNEW OVER WHERE WITH XOR
        )
      end

      # Boolean and null constants
      def self.constants
        @constants ||= Set.new %w(
          false FALSE null NULL true TRUE
        )
      end

      # Built-in and internal fields
      def self.builtin_fields
        @builtin_fields ||= Set.new %w(
          _bkt _cd _indextime _kv _raw _serial _si _sourcetype _subsecond _time
          date_hour date_mday date_minute date_month date_second date_wday
          date_year date_zone eventtype host index linecount punct source
          sourcetype splunk_server tag timeendpos timestartpos
        )
      end

      state :root do
        # Whitespace
        rule %r/\s+/m, Text

        # Block comments (triple backtick)
        rule %r/```/, Comment::Multiline, :block_comment

        # Double-quoted strings
        rule %r/"/, Str::Double, :double_string

        # Single-quoted strings (field names / literal values)
        rule %r/'/, Str::Single, :single_string

        # Backtick macro references (not triple backtick)
        rule %r/`(?!``)/, Name::Function, :backtick_string

        # Macro argument substitution: $varname$
        rule %r/\$\w+\$/, Name::Variable

        # Numeric literals — floats before integers to avoid partial matches
        rule %r/\d+\.\d+(?:e[+-]?\d+)?/i, Num::Float
        rule %r/\d+(?:e[+-]?\d+)?/i,       Num::Integer

        # Brackets and braces
        rule %r/[\[\]{}]/, Punctuation

        # Pipe operator
        rule %r/\|/, Punctuation

        # Comparison operators (longest match first)
        rule %r/[<>!]=|[<>]/, Operator
        rule %r/==/, Operator

        # Arithmetic and string-concatenation operators
        rule %r/[+\-*\/%]/, Operator
        rule %r/\.\./, Operator
        rule %r/\./, Operator

        # Time snap operator and other special characters
        rule %r/@/, Operator
        rule %r/:/, Punctuation
        rule %r/\$/, Operator

        # Other punctuation
        rule %r/[(),;]/, Punctuation

        # Assignment / field=value
        rule %r/=/, Operator

        # Wildcard
        rule %r/\*/, Operator

        # Percentile functions with numeric suffix: perc90, p95, exactperc99, upperperc90
        rule %r/(?:exactperc|upperperc|perc|p)\d+\b/, Name::Builtin

        # Words — classify by set membership
        rule %r/\w+/ do |m|
          word       = m[0]
          word_lower = word.downcase
          word_upper = word.upcase
          if self.class.constants.include?(word)
            token Keyword::Constant
          elsif self.class.operator_words.include?(word_upper)
            token Keyword::Pseudo
          elsif self.class.commands.include?(word_lower)
            token Keyword
          elsif self.class.eval_functions.include?(word_lower)
            token Name::Builtin
          elsif self.class.stats_functions.include?(word_lower)
            token Name::Builtin
          elsif self.class.builtin_fields.include?(word_lower)
            token Name::Variable::Magic
          else
            token Name
          end
        end
      end

      state :block_comment do
        rule %r/```/,    Comment::Multiline, :pop!
        rule %r/[^`]+/,  Comment::Multiline
        rule %r/`/,      Comment::Multiline
      end

      state :double_string do
        rule %r/\\./,      Str::Escape
        rule %r/"/,        Str::Double, :pop!
        rule %r/[^\\"]+/,  Str::Double
      end

      state :single_string do
        rule %r/\\./,      Str::Escape
        rule %r/'/,        Str::Single, :pop!
        rule %r/[^\\']+/,  Str::Single
      end

      state :backtick_string do
        rule %r/`/,     Name::Function, :pop!
        rule %r/[^`]+/, Name::Function
      end
    end
  end
end
