# if mac
if (/darwin/ =~ RUBY_PLATFORM) != nil
    puts "You're on mac"
# if linux
else
    puts "You're not on mac"
end