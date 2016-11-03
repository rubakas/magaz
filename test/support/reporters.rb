require "minitest/reporters"
reporters_to_use = [
  Minitest::Reporters::MeanTimeReporter.new(show_count: 3, sort_column: :last)
]

Minitest::Reporters.use! reporters_to_use
