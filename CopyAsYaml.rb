#! /usr/bin/ruby
require 'shellwords'

def yml_val(v)
  return v if v =~ /\A[1-9][0-9]*\z/
  return nil if v == 'NULL'
  '"' + v + '"'
end

STDIN.set_encoding('UTF-8')

row = STDIN.gets
head = row.chomp.split("\t")
yml = ''
while row = STDIN.gets
  yml += "\-\n"
  row.chomp.split("\t").each_with_index do |v, i|
    yml += "  #{head[i]}: #{yml_val(v)}\n"
  end
end

system("echo #{yml.shellescape} | __CF_USER_TEXT_ENCODING=#{Process::UID.rid}:0x8000100:0x8000100 pbcopy")
