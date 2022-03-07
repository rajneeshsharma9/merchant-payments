require 'csv'

namespace :merchants do
  desc "Import merchants to a store from a CSV file"
  task :import_from_csv, [:file_url] => :environment do |_task, args|
    if args[:file_url]
      begin
        csv_text = File.read(args[:file_url])
        csv = CSV.parse(csv_text, headers: true)
        puts "Importing merchants from #{args[:file_url]}"
        csv.each_with_index do |row, index|
          merchant = Merchant.new(row.to_hash)
          unless merchant.save
            puts "Importing merchant failed in row #{index + 1} of csv, please check data"
          end
        end
      rescue Exception => e
        puts "Importing merchants failed, please check data in CSV"
      end
      puts "Importing merchants from #{args[:file_url]} completed"
    else
      puts "Provide CSV file url as argument"
    end
  end
end
