rule -> (date) { date.tuesday? } do |time_frames|
  time_frames[:morning] << "Go swimming"
end

rule -> (date) { date.tuesday? } do |time_frames|
  time_frames[:evening] << "Read a book"
end
