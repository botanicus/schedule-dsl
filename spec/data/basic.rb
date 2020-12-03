rule Proc.new { true } do
  "Go swimming"
end

rule Proc.new { false } do
  "Steal things from little kids"
end

rule -> (date) { date.tuesday? } do
  "Read a book"
end
