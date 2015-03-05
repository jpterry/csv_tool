module CsvTool
  module FileManipulation
    class CsvJoiner

      def initialize(infile_names, outfile_name)
        @infile_names = [*infile_names]
        @outfile_name = outfile_name

        @header_already_inserted = false
      end

      def join!
        CSV.open(@outfile_name, 'wb') do |csv_out|
          @infile_names.each do |file_name|
            append_file(csv_out, file_name)
          end
        end
      end

      private

      def append_file(csv_out, in_filename)
        first_line_read = false

        CsvTool.foreach_with_smart_transcoding(in_filename) do |row|
          if first_line_read
            csv_out << row
          else
            first_line_read = true
            unless @header_already_inserted
              csv_out << row
              @header_already_inserted = true
            end
          end
        end
      end
    end

    class CsvSplitter
      SPLIT_COUNT_DEFAULT = 250_000
      COPY_HEADERS_DEFAULT = true

      def initialize(filename, outfile_basename, split_count = SPLIT_COUNT_DEFAULT, copy_headers = COPY_HEADERS_DEFAULT)
        @split_count = split_count
        @copy_headers = copy_headers

        @filename = filename
        @header = nil
        @file_count = 1
        @outfile = File.open("split_out_#{@file_count}.csv", 'wb')
      end


      def split
        row_count = 0
        CSV.foreach(@filename, col_sep: ',') do |row|
          row_count += 1
          @header ||= row

          if (row_count % @split_count) == 0
            puts row_count
            start_new_file
          end
          outfile << row.to_csv
        end
      end

      def start_new_file
        puts "Closing #{@outfile.path}"
        @outfile.close
        @outfile = File.open("split_out_#{@file_count+=1}.csv", 'wb')
        puts "Starting #{@outfile.path}"
        @outfile << @header.to_csv if @copy_headers
      end

      def outfile
        @outfile
      end
    end
  end
end
