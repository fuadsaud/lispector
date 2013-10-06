module Lispector
  class Parser
    def ast(string)
      p parse(tokenize(string))
    end

    def parse(tokens)
      fail 'unexpected token "EOF"' if tokens.empty?

      token = tokens.shift
      case token
      when '('
        l = []

        until tokens.first == ')'
          l << parse(tokens)
        end

        tokens.shift # remove the ")"

        l
      when ')'
        fail SyntaxError, 'unexpected token ")"'
      else
        atom(token)
      end
    end

    def tokenize(string)
      string.lines.flat_map { |line|
        line
          .gsub('(', '( ')
          .gsub(')', ' )')
          .split
      }
    end

    def atom(token)
      Integer(token) rescue Float(token) rescue token.to_sym
    end
  end
end
