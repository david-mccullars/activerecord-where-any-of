RSpec::Matchers.define :match_ignoring_whitespace do |expected|
  match do |actual|
    expected.to_s.gsub(/\s/, '') == actual.to_s.gsub(/\s/, '')
  end

  failure_message do |actual|
    sep = '=' * 80
    <<-END
#{sep}
Expected:
#{expected.to_s.strip}
#{sep}
Actual:
#{actual.to_s.strip}
#{sep}
    END
  end
end
