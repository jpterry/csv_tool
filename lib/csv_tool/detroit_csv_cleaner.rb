module CsvTool
  class DetroitCsvCleaner
    def initialize
      @headers = nil # we take the first row as headers
      @current_line = 0
      @long_line_count = 0
      @line_lengths = Hash.new(0)
    end

    def valid_date?( str, format="%m/%d/%Y" )
      Date.strptime(str,format) rescue false
    end

    MATCHERS = {
      vendor_num: /\A\d+\z/,
      # lol simple. Found this on the webz
      simple_date: %r#\A(?:(?:(?:(?:0?[13578])|(1[02]))/31/(19|20)?\d\d)|(?:(?:(?:0?[13-9])|(?:1[0-2]))/(?:29|30)/(?:19|20)?\d\d)|(?:0?2/29/(?:19|20)(?:(?:[02468][048])|(?:[13579][26])))|(?:(?:(?:0?[1-9])|(?:1[0-2]))/(?:(?:0?[1-9])|(?:1\d)|(?:2[0-8]))/(?:19|20)?\d\d))\Z#
    }

    VENDOR_NUM_INDEX = 1
    CHECK_DATE_INDEX = 4
    DESC_INDEX = 3

    def check_line!(line)
      @current_line +=1
      @headers ||= line
      @line_lengths[line.length] += 1

      shift1 = shift2 = nil

      return line if line == @headers
      original_line = line.dup

      vendor_num_i = line.find_index {|i| i =~ MATCHERS[:vendor_num] }
      if vendor_num_i
        vendor_shift = vendor_num_i - VENDOR_NUM_INDEX
        if vendor_shift > 0
          line = line_with_cells_collapsed(line, VENDOR_NUM_INDEX-1..VENDOR_NUM_INDEX-1+vendor_shift)
          shift1 = true
        end
      else
        puts "NO VENDOR NUMBER"
        puts line
      end

      inv_date_i   = line.find_index {|i| i =~ MATCHERS[:simple_date] }
      if inv_date_i

        check_date_shift = inv_date_i - CHECK_DATE_INDEX

        if check_date_shift > 0
          line = line_with_cells_collapsed(line, DESC_INDEX..DESC_INDEX+check_date_shift)
          shift2 = true
        end
      else
        puts "NO DATE"
        puts line
      end

      if line.length != @headers.length
        require 'pry'; binding.pry
      end

      line
    end

    def line_with_cells_collapsed(line, collapse_range)
      new_line = line.dup
      insert_i = collapse_range.first

      insert_string = new_line[collapse_range].join(",")
      collapse_range.size.times do
        new_line.delete_at(insert_i)
      end
      new_line.insert(insert_i, insert_string)
      new_line
    end
  end
end
