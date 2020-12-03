# About

_Provides a DSL for defining your schedule rules and getting results for given date._

## Examples

### Collect returned values

```ruby
rule Proc.new { true } do
  "Go swimming"
end

rule Proc.new { false } do
  "Steal things from little kids"
end

rule -> (date) { date.tuesday? } do
  "Read a book"
end
```

```ruby
require 'schedule'

table = Schedule.load(definition_file_path)
table.filter(Date.today).evaluate
# => ["Go swimming", "Read a book"]
```

### Use a collector object

```ruby
rule -> (date) { date.tuesday? } do |time_frames|
  time_frames[:morning] << "Go swimming"
end

rule -> (date) { date.weekday? } do |time_frames|
  time_frames[:evening] << "Read a book"
end
```

```ruby
require 'schedule'

table = Schedule.load(definition_file_path)
time_frames = {morning: Array.new}
table.filter(Date.today).evaluate(time_frames) # Ignore the result.
time_frames # => {morning: "Go swimming"}
```

# API

## Custom `Date` extensions

Date passed as an argument to the condition is extended with `Schedule::DateExts`.

- `Date#weekend?`
- `Date#weekday?`
- `Date#last_day_of_a_month?`
