# frozen_string_literal: true

# For testing excerpt handling of custom tags

module Bridgetown
  class DoNothingBlock < Liquid::Block
  end

  class DoNothingOther < Liquid::Tag
  end
end

Liquid::Template.register_tag("do_nothing", Bridgetown::DoNothingBlock)
Liquid::Template.register_tag("do_nothing_other", Bridgetown::DoNothingOther)
