module Lispector
  class Evaluator
    def eval(sexp, binding: {})
      case sexp
      when Symbol
        binding.fetch(sexp) { fail NameError, "undefined name #{ sexp }" }
      when Array
        case sexp.first
        when :quote
          sexp.butfirst
        when :if
          _, test, conseq, alt = sexp

          eval(eval(test, binding) ? conseq : alt, binding)
        when :set!, :define
          _, name, exp = sexp

          binding[name] = eval(exp, binding: binding)
        when :binding
          binding
        when :lambda, :'->'
          _, params, exp = sexp

          build_lambda(params: params, exp: exp, outer_binding: binding)
        else
          ƛ, *args = sexp.map { |s| eval(s, binding: binding) }

          ƛ.(*args)
        end
      else
        sexp
      end
    end

    private

    def build_lambda(params: [], exp: [], outer_binding: {})
      puts outer_binding
      ->(*args) {
        puts "RODA O LAMBDA"
        puts outer_binding.merge(a_to_h(args.zip(params)))
        eval(
          exp, binding: outer_binding.merge(a_to_h(params.zip(args)))
        )
      }
    end

    def a_to_h(array)
      array.each_with_object({}) { |(k, v), acc| acc[k] = v }
    end

    class Lambda < SimpleDelegator
      def inspect
        "<Proc:#{ object_id.to_s(16) }#{ ' (lambda)' if lambda? }>"
      end
    end
  end
end
