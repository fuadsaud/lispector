module Lispector
  Error       = Class.new(Exception)
  SyntaxError = Class.new(Lispector::Error)
  NameError   = Class.new(Lispector::Error)
end
