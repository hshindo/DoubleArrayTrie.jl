workspace()
using DoubleArrayTrie

homedir()
pwd()
lines = open(readlines, joinpath(pwd(),"test/words.txt"))
sort!(lines)

words = map(chomp, lines)
keys = map(w -> [Int(c) for c in w], words)
trie = DATrie(keys, words)

get(trie, [35], "")

for i = 1:length(words)
  v = get(trie, keys[i], "")
  @assert v == words[i]
end
