require 'generator'

class Insulter
  include Generator

  def insults
    phrases
  end

  def phrases
    phrase + ". " + maybe { phrases }
  end

  def phrase
    pick_one(
      -> { you_are },
      -> { you_blank },
      -> { verb_your_relative }
    )
  end

  def verb_your_relative
    "Go " + bad_verb + " your " + nice_relative
  end

  def nice_relative
    pick_one("Grandma", "mother", "sister", "pet rabbit", "local priest", "favorite nun")
  end

  def bad_verb
    pick_one("fuck", "screw", "diddle", "molest", "man-handle")
  end

  def you_are
    "You are " + maybe { "such " } + a(bad_name)
  end

  def you_blank
    "You " + maybe { emphasizing_adjective } + bad_name
  end

  def bad_name
    ' ' + pick_one("dick wad", "asshole", "asshat")
  end

  def emphasizing_adjective
    ' ' + pick_one("fucking", "freaking", "unbelievable")
  end
end
