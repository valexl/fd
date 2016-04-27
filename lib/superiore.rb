raise 'make "bundle install" before' unless require 'mechanize'


def get_stage(url)
  (1..3).each do |attempt|
    agent = Mechanize.new
    agent.max_history = 0
    agent.user_agent_alias = "Mac Safari"
    begin
      return agent.get(url) 
    rescue 
      puts '-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#'
      puts url
      puts '-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#'
    end  
  end
  nil
end

class Menu
  def initialize
    @stage = get_stage("https://www.superiore.de")
  end

  def all_categories
    @all_categories ||= @stage.search("div.bar.categories.menu ul.dropdown").to_a[0..5].inject([]) do |res, ul|
      res += ul.search("a").to_a
    end
  end

  def all_categories_urls
    all_categories.map {|a| a["href"].split("?")[0]}.select { |url| (!url.include?("javascript")) }
  end
end

#################
#################
#################

class Category
  attr_reader :url
  def initialize(url)
    @url = url
    @stage = get_stage(@url)
    @current_page = @stage.search(".locator a.active")[0].attr("id").gsub(/\D/, '').to_i
    puts @current_page
  end

  def all_products_urls
    @stage.search("[rel='product']").map { |a| a.attr("href").split("?")[0] }.uniq
  end

  def next_page
    puts "next page is - #{@current_page + 1}"
    page_link = @stage.search(".locator a#test_PageNrBottom_#{@current_page + 1}")[0]
    return nil if page_link.nil?
    Category.new(page_link.attr("href")) rescue nil
  end
end

########################
########################
########################


class Product
  def initialize(url)
    @url = url
    @stage = get_stage(@url)
  end

  def h1
    @stage.search("h1.fn")[0]
  end

  def attributes_block
    return @attributes_block if @attributes_block
    parent = h1.parent
    describtion_section = parent.search(".desc.description")[0]
    @attributes_block = describtion_section.next
    while !@attributes_block.nil?
      break if @attributes_block.attr('class').to_s.strip.include?('attributes')
      @attributes_block = @attributes_block.next
    end
    return @attributes_block unless @attributes_block.nil?

    
    html_tag = parent.next
    while !html_tag.nil?
      if html_tag.search('.attributes').count > 0
        @attributes_block = html_tag.search('.attributes')
        break 
      end
      html_tag = html_tag.next
    end

    @attributes_block 
  end

  def product_name
    h1.text.strip
  end

  def producer
    a = h1.next
    while !a.nil?
      break if a.name == 'a'
      a = a.next
    end
    a.attr("title").strip
  end

  def address
    h1.next.next.next.next.text.squeeze(" ").strip
  end

  def description
    @stage.search(".desc.description").text
  end

  def price
    @price   = @stage.search(".cats .prod_footer big").first.text.gsub(/\s/, '').gsub(/\,/, '.')
  end

  def volume
    @volume   = @stage.search(".cats .prod_footer big").first.parent().next.text.gsub(/\s/, '').gsub(/\,/, '.')
  end

  def availability
    @availability = @stage.search(".cats .prod_footer .status")[0].text.strip
    @availability = @availability.to_s.length.zero? ? "< 24 Stück verfügbar" : @availability
  end

  def additional_content
    return @additional_content if @additional_content
    raiting_content = get_spans[:raiting].inject([]) do |res, span|
      item   = try_get_raiting_item(span)
      res.push(item)
    end

    other_content = get_spans[:other].inject([]) do |res, span|
      item ||= try_get_other_item(span)
      res.push(item)
    end

    @additional_content = (raiting_content + [try_get_rebsorte] + other_content).select {|el| el.to_s.length > 0 }
  end
  
  private

    def get_spans
      return @get_spans if @get_spans
      was_separator = false
      raiting_spans = []
      other_spans   = []

      if @stage.search(".review.small").count > 0
        raiting_spans.push(@stage.search(".review.small").first)
      end

      if attributes_block.search(".desc").count.zero?
        other_spans = attributes_block.children.select{ |current_element| current_element.name == 'span' }
      else
        attributes_block.children.each do |current_element|
          if current_element.name == 'span'
            if was_separator
              other_spans.push(current_element)
            else
              raiting_spans.push(current_element)
            end
          elsif current_element.name == 'div' && current_element.attr("class").strip == 'desc'
            was_separator = true
          end

          current_element = current_element.next
        end
      end
      @get_spans = { :raiting => raiting_spans, other: other_spans }
    end

    def try_get_raiting_item(span)
      item = try_get_raiting_from_a(span)
      item ||= try_get_raiting_from_span(span)
      item = item.gsub(/\s/, " ").gsub(/\s:/, ':').gsub(" :", ':').gsub(/\(\d+\)/, '').squeeze(" ").strip
    end

    def try_get_other_item(span)
      begin
        span.text.gsub(/\s/, " ").squeeze(" ").strip
      rescue Exception => e
      end
    end

    ##############
    ## Raiting ##
    ##############

    def try_get_raiting_from_a(span)
      begin
        a = span.search("a.artikel")[0]
        title = a.text
        title += " #{a.next.text}"
        raiting = File.basename(span.search("img")[0].attr('src'))[0].to_i
        raiting = nil if raiting.zero?
        "Rating #{title} #{raiting}"
      rescue Exception => e
      end
    end

    def try_get_raiting_from_span(span)
      begin
        title, raiting = span.text.gsub(/\s/, ' ').strip.split(":")
        raiting = raiting.to_i.zero? ? nil : raiting
        raiting ||= File.basename(span.search("img")[0].attr('src'))[0]
        "Rating #{title}: #{raiting}"
      rescue Exception => e
      end
    end


  
    ##############
    ## Rebsorte ##
    ##############
    def try_get_rebsorte
      begin
        @rebstore = attributes_block.children[0].text
        unless @rebstore.include?("Rebsorten")
          @rebstore = attributes_block.search(".desc")[0].next.text
        end
        @rebstore = @rebstore.gsub("\n", " ").gsub("\r", " ").gsub("\t", " ").squeeze(" ").strip
      rescue Exception => e
      end
    end

end


