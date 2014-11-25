task default: [:insult]

task insult: [:init] do
  with(Insulter.new, &putser)
end

task compliment: [:init] do
  with(Complimenter.new, &putser)
end

task say_insult: [:init] do
  with(Insulter.new, &speaker)
end

task say_compliment: [:init] do
  with(Complimenter.new, &speaker)
end

def with(generator)
  3.times { yield(generator.phrases) }
end

def putser
  ->(s) { puts s }
end

def speaker
  ->(s) {
    puts s
    `espeak "#{s}"`
  }
end

task :init do
  $LOAD_PATH << './lib'
  require 'complimenter'
  require 'insulter'
end
