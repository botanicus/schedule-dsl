rule -> (date) { date.tuesday? } do |time_frames|
  time_frames[:morning] << "Go swimming"
end

# Date#weekday? is one of the custom date extensions
# defined in Schedule::DateExts.
rule -> (date) { date.weekday? } do |time_frames|
  time_frames[:evening] << "Read a book"
end
