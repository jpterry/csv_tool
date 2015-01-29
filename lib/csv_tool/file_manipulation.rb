module CsvTool
  module FileManipulation
    class CsvJoiner

      def initialize(infile_names, outfile_name)
        @infile_names = [*infile_names]
        @outfile_name = outfile_name

        @header_already_inserted = false
        @row_count = 0
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
            puts @row_count += 1
          else
            first_line_read = true
            unless @header_already_inserted
              csv_out << row
              puts @row_count += 1
              @header_already_inserted = true
            end
          end
        end
      end
    end
  end
end
