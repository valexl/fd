load 'lib/superiore.rb'
require 'thread'
require 'fileutils'


puts '!!!!!!'
puts "STARRT AT #{Time.now}"
puts '!!!!!!'

FileUtils.rm_rf Dir.glob("tmp/*")


work_queue = Queue.new


Menu.new.all_categories_urls.each do |category_url|
  begin
    category = Category.new(category_url)

    while !category.nil? do
      puts " -------------- #{category.url} --------------"
      work_queue.push(category)
      category = category.next_page
    end
  rescue Exception => e
  end
end 

workers = (0..work_queue.length).map do
  Thread.new do
    begin
      category = work_queue.pop(true)
      category.all_products_urls.each do |product_url|
        product = Product.new(product_url)
        errors = []
        begin
          errors.push('blank product_name') if product.product_name.length.zero?
          errors.push('blank producer') if product.producer.length.zero?
          errors.push('blank address') if product.address.length.zero?
          errors.push('blank description') if product.description.length.zero?
          errors.push('blank additional_content') if product.additional_content.length.zero?
          errors.push('blank price') if product.price.length.zero?
          errors.push('blank volume') if product.volume.length.zero?
          errors.push('blank availability') if product.availability.length.zero?
          raise 'error' if errors.length > 0
          file_name = "tmp/data_#{category.url.split("https://www.superiore.de")[1].gsub("/", '')}.txt"

          open(file_name, 'a+') { |f|
            f.puts '######################'
            f.puts product_url
            f.puts '######################'
            f.puts product.product_name
            f.puts product.producer
            f.puts product.address
            f.puts product.description
            f.puts product.additional_content
            f.puts product.price
            f.puts product.volume
            f.puts product.availability
          }
        rescue Exception => e
          puts '###########'
          puts e
          puts '###########'
          puts errors
          puts '###########'
          puts product_url
          puts '###########'
        end
      end


    rescue ThreadError
      
    end
  end

end

workers.map(&:join); "ok"

puts '!!!!!!'
puts "FINISH AT #{Time.now}"
puts '!!!!!!'




# FileUtils.rm_rf Dir.glob("tmp/*")

# work_q = Queue.new
# (0..7).to_a.each{|x| work_q.push x }
# index = 0
# workers = (0...7).map do
#   index = Time.now
#   Thread.new do
#     begin
#       file_name = "tmp/data_#{Dir["tmp/**/*"].length}.txt"
#       while x = work_q.pop(true)
#         open(file_name, 'a+') do |f|
#           10.times { f.puts Time.now }
#         end
#         # 50.times{print [128000+x].pack "U*"}
#       end
#     rescue ThreadError
#     end
#   end
# end; "ok"
# workers.map(&:join); "ok"
