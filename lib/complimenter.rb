require 'generator'

class Complimenter
  include Generator

  def compliments
    phrases
  end

  def phrases
    phrase + ". " + maybe { phrases }
  end

  def phrase
    pick_one(
      -> { you_make_me },
      -> { you_have_a },
      -> { you_have },
      -> { i_love_you },
      -> { when_i_am },
      -> { you_are }
      )
  end

  def you_are
    "You are" + adverbs + adjective
  end

  def when_i_am
    "When I am " + bad_emotion + " you " + pick_me_up + emphatic
  end

  def pick_me_up
    pick_one("cheer me up", "kick my ass into gear", "put the wind back in my sails")
  end

  def bad_emotion
    pick_one("sad", "down", "upset", "freaking out", "in the lost-and-found", "throwing a tantrum")
  end

  def i_love_you
    "I love you"
  end

  def you_make_me
    "You make me" + maybe { adverbs } + verb + maybe(0.25) { adverbs } + emphatic
  end

  def you_have
    "You have" + adjectives + plural_attribute + emphatic
  end

  def you_have_a
    "You have " + a(adjectives + singular_attribute) + emphatic
  end

  def emphatic
    maybe(0.95) {
      ", " +
      pick_one(
          "really",
          "you really do",
          "you do",
          -> { "I swear" + maybe {" it" } },
          -> { maybe { "up" } + "on my grandmother's grave" },
          "by Jove",
          "you don't even know",
          "seriously",
          "I mean it"
        ) +
      maybe(0.3) { emphatic }
    }
  end

  def adjectives
    adjective + maybe(0.25) { adjectives }
  end

  def adjective
    " " + pick_one("beautiful", "glorious", "wonderful", "wiggly")
  end

  def plural_attribute
    " " + pick_one("eyes", "ears", "fingers", "thumbs", "toes", "feet", "nostrils", "hair")
  end

  def singular_attribute
    " " + pick_one("voice", "nose", "face", "sense of humor", "poise", "grace", "mind", "heart", "soul", "laugh")
  end

  def adverbs
    adverb + maybe(0.25) { adverbs }
  end

  def adverb
    " " + pick_one("with happiness", "ecstatically", "beautifully", "gloriously")
  end

  def verb
    " " + pick_one("swoon", "dance", "sing", "be a better person")
  end
end


# Try re-writing that w/ a PEG, and have the result of eval'ing a string
# be ANOTHER STRING, which is fed back in, and the rules are stochastic, but
# eventually stop emitting:
# and when they do, they start emitting the result.


# complimenter = Complimenter.new
# 5.times { puts compliment = complimenter.compliments }
# puts compliment
# puts compliment.size
# `say "#{compliment}"`

# mega_compliment = Array.new(300) { complimenter.compliments }.join(". ")
# puts mega_compliment
# `say #{mega_compliment.gsub("'", "")}`

# tweets = Array.new(10000) { Complimenter.new.tweet }
# puts tweets.count { |c| c.size > 140 }
# puts tweets.select { |c| c !~ /\.\s*$/ }

