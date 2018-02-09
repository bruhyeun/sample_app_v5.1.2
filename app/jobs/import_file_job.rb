require 'csv'

class ImportFileJob < ApplicationJob
  queue_as :import

  def perform(code, file)
    @project = Project.find_by(code: code)
    puts file
    CSV.foreach(file, headers: true) do |row|
      filename = file.split("/").last
      if @data_table.nil?
        @data_table = @project.data_tables.build(source_filename: filename,
                                 source_folder: file.gsub("/#{filename}", ""),
                                 header: row.headers.to_s.gsub("/", ""),
                                 data: "")
        @data_table.save!
      else
        @data_record = @data_table.data_records.build(row: row)
        @data_record.save!
      end
    end
    File.delete(file)
  end
end
