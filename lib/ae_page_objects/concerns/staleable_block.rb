module AePageObjects
  class StaleBlockError < StandardError
  end
  
  module Concerns
    module StaleableBlock
      extend ActiveSupport::Concern

      module ClassMethods
        def new(*args)
          return super unless block_given?

          # A super() call always passes the block. We want to 'consume'
          # the block, so we pass a new one to wrap the passed one
          super(*args) do |obj|
            yield obj

            unless obj.stale?
              raise StaleBlockError, "Block completed with non-stale page object #{obj.__name__}."
            end
          end

          # don't return the stale object
          nil
        end
      end
    end
  end
end
