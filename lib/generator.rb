module Generator
  def pick_one(*items)
    chosen = items.sample
    if chosen.respond_to?(:call)
      chosen.call
    else
      chosen
    end
  end

  def maybe(p=0.5)
    rand < p ? yield : ''
  end

  def a(word)
    if word =~ /^\s*[aeiou]/
      "an #{word}"
    else
      "a #{word}"
    end
  end
end
