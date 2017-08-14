require 'roo'

# Get input file name.
unless filename = ARGV[0] and File.exist?(filename)
  puts "Usage: #{$0} redirects.xlsx"
  exit
end

# Open the spreadsheet and get basic info.
xlsx = Roo::Spreadsheet.open(filename)
puts xlsx.info

# Locate PlugNPay sheet by finding the first sheet with "VisaMC" in the name.
redirect_sheet_name = xlsx.sheets.first
puts "Redirect sheet: #{redirect_sheet_name.inspect}"

output_filename = "nginx.conf"
puts "Output file: #{output_filename}"
output = File.new(output_filename, "w+")

(redirect_sheet = xlsx.sheet(redirect_sheet_name)).
  each(oldURL: 'old URL', newURL: 'new URL') do |row|
    next if row[:oldURL].nil?

    # Strip the path part of the URL out from the full URL.
    old_url_path = row[:oldURL].gsub(/https?\:\/\/[^\/]+(\/.*$)/,'\1')

    new_url_path = if row[:newURL] =~ /\/$/
        row[:newURL]
      else
        row[:newURL] + '/'
      end

    # Don't redirect if they're equal.
    next if new_url_path == old_url_path

    puts "redirect: #{old_url_path} -> #{new_url_path}"
    output.puts <<EOR
rewrite
^#{old_url_path}$
#{new_url_path} permanent;

EOR
end
output.close
