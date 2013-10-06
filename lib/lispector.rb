require 'powerpack'
require 'delegate'

require_relative 'lispector/version'
require_relative 'lispector/errors'
require_relative 'lispector/parser'
require_relative 'lispector/evaluator'

module Lispector
  @global_env = {}

  def self.eval(string)
    Evaluator.new.eval(Parser.new.ast(string), binding: @global_env)
  end

  def self.lispify(expression)
    case expression
    when Array
      "(#{ expression.reduce { |buffer, i| "#{ buffer } #{ lispify(i) }" } })"
    else
      expression.to_s
    end
  end
end
