require 'csv'
require 'json'

csv_data = CSV.read('csv.csv', headers: true)

json_data = csv_data.map do |row|
  {
    parent_category_name: row['parent_category_name'],
    category_name: row['category_name'],
    required_credit_point: row['required_credit_point'].to_f,
    image_url: row['image_url']
  }
end

json_file = File.open('data.json', 'w')
json_file.write(json_data.to_json)
json_file.close
