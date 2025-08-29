def substrings(words, dictionary)
  found = Hash.new(0) #start every new hash entry with a value of 0
  
  (words.split(" ")).each do | word |
    dictionary.each do |entry|
      if (word.downcase).include?((entry.downcase))
        found[entry] +=1
      end
    end
  end

  puts found
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
substrings("below", dictionary) #in this example, below and low are in the dictionary and in below
substrings("Howdy partner, sit down! How's it going?", dictionary)
