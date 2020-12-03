# About

_Provides a DSL for defining your schedule rules and getting results for given date._

_Here we are talking about schedule as in your personal schedule, specifically set points in your routine that makes sense to describe programatically (you could use it for instance to build a habit tracking app). It is not about schedule as in schedulers, cron and the like._

## Note about generic use as a rule library

In future I might extract it as a generic rule library. There are rules with a condition (that could optionally be passed any object or objects) and a body (that could also be optionally passed any object or objects). The only place where we have opinions about the passed object is the `#filter` method where we extend the passed date object with `DateExts`).

At the end of the day `DateExts` sounds like something end-user should take care of and the `#filter` method should only allow filters to be run when an object (or objects) is passed.

Obviously this would require changing name of the repo, gem name and renaming the variables.

# Installation

Run `gem install schedule-dsl`.

# Examples

## Collect returned values

```ruby
# Your definition file.

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
# Your script.

require 'schedule'

table = Schedule.load(definition_file_path)
table.filter(Date.today).evaluate
# => ["Go swimming", "Read a book"]
```

## Use a collector object

```ruby
# Your definition file.

rule -> (date) { date.tuesday? } do |time_frames|
  time_frames[:morning] << "Go swimming"
end

rule -> (date) { date.weekday? } do |time_frames|
  time_frames[:evening] << "Read a book"
end
```

```ruby
# Your script.

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
