task default: [:insult]

task insult: [:init] do
  require 'insulter'
  3.times do
    puts Insulter.new.insults
  end
end

task compliment: [:init] do
  require 'complimenter'
  3.times do
    puts Complimenter.new.compliments
  end
end

task say_insult: [:init] do
  require 'insulter'
  3.times do
    Insulter.new.insults.tap do |insult|
      puts insult
      `espeak "#{insult}"`
    end
  end
end

task say_compliment: [:init] do
  require 'complimenter'
  3.times do
    Complimenter.new.compliments.tap do |c|
      puts c
      `espeak "#{c}"`
    end
  end
end

def say(message)
  `espeak #{message}`
end

task :init do
  $LOAD_PATH << './lib'
end
