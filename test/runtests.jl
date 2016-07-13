using Base.Test
using DoubleArrayTrie

lines = open(readlines, joinpath(pwd(),"words.txt"))
sort!(lines)

words = map(chomp, lines)
keys = map(w -> [Int(c) for c in w], words)
trie = DATrie(keys, words)

for i = 1:length(words)
  v = get(trie, keys[i], "")
  @test v == words[i]
end
