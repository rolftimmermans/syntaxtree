module SyntaxTree
  module Events
    module Parameters
      def on_params(regulars, optionals, splat, trailing_regulars, block)
        parameter_list = Ruby::ParameterList.new.concat regulars

        optionals.each do |identifier, default|
          parameter_list.push Ruby::DefaultParameter.new(
            identifier: identifier,
            operator: tokens.pop(:"="),
            default: default)
        end if optionals

        parameter_list.push(splat).concat(trailing_regulars).push(block)
      end

      def on_rest_param(identifier)
        Ruby::SplatParameter.new identifier: identifier, left_delim: tokens.pop(:"*")
      end

      def on_blockarg(identifier)
        Ruby::BlockParameter.new identifier: identifier, left_delim: tokens.pop(:"&")
      end

      def on_excessed_comma(token)
        # Excessed comma is added to token prologues.
      end
    end
  end
end
