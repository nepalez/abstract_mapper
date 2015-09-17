# encoding: utf-8

class AbstractMapper

  module Errors

    # An exception to be raised when wrong node is registered as a DSL command
    #
    # @api public
    #
    class WrongRule < TypeError

      # @private
      def initialize(node)
        super "#{node} is not a subclass of AbstractMapper::Rules::Base"
        IceNine.deep_freeze(self)
      end

    end # class WrongRule

  end # module Errors

end # class AbstractMapper
