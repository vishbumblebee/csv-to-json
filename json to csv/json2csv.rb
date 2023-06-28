require 'json'
require 'csv'

# Opening JSON file and loading the data into the variable data
data = File.open("abhi1.json") do |file|
  JSON.load(file)
end

employee_data = data
data_file = File.open("data_file.csv", "w")

csv_writer = CSV.new(data_file)
count = 0

data.each do |categories|
  if count == 0
    # Writing headers of CSV file
    header = [
      "parent_category_name",
      "category_name",
      "required_credit_point",
      "image_url"
    ]
    csv_writer << header
    count += 1
  end

  image_url = "https://fastly.picsum.photos/id/0/5000/3333.jpg?hmac=_j6ghY5fCfSD6tvtcV74zXivkJSPIfR9B8w34XeQmvU"
  credit_points = 1.0

  parent_categ = if categories["parent_name"].include?(",")
                   categories["parent_name"].gsub(",", "_")
                 else
                   categories["parent_name"]
                 end
  csv_writer << ["", parent_categ, credit_points, image_url]

  categories["categories"].each do |categ|
    csv_writer << [
      parent_categ,
      if categ["category_name"].include?(",")
        categ["category_name"].gsub(",", "_")
      else
        categ["category_name"]
      end,
      credit_points,
      image_url
    ]
  end
end

data_file.close
