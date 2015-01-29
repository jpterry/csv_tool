require "csv_tool/version"

require 'csv'
require 'charlock_holmes'

module CsvTool
  require 'csv_tool/detroit_csv_cleaner'
  require 'csv_tool/file_manipulation'


  def self.foreach_with_smart_transcoding(filename, &blk)
    @encoding_detector ||= CharlockHolmes::EncodingDetector.new

    detection  = @encoding_detector.detect(File.read(filename))
    CSV.foreach(filename, encoding:"#{detection[:encoding]}:utf-8", &blk)
  end
end
