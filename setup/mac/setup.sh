/usr/bin/ruby -e Command << HeredocDelimiter
def download(input_1=nil, from:nil, url:nil, as:nil)
    require "open-uri"
    # argument checking 
        # if only one argument, either input_1 or url
        if ((input_1!=nil) != (url!=nil)) && (from==nil) && (as==nil)
            the_url = url || input_1
            file_name = the_url.match /(?<=\/)[^\/]+\z/ 
            file_name = file_name[0]
        elsif (as != nil) && ((input_1!=nil)!=(url!=nil))
            the_url = url || input_1
            file_name = as
        elsif ((from!=nil) != (url!=nil)) && input_1!=nil
            the_url = from || url
            file_name = input_1
        end

    # actually download the file
    open(file_name, "wb") do |file|
        file << open(the_url).read
    end
end

download("https://raw.githubusercontent.com/aggie-tool-kit/atk/master/setup/mac/setup.rb", as: "./setup.rb")
system "ruby setup.rb"
HeredocDelimiter