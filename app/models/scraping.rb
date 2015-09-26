class Scraping

  def self.movie_urls
    links = []
    agent = Mechanize.new
    next_url = "/now/"

    while true do
      current_page = agent.get("http://eiga.com" + next_url)
      elements = current_page.search('.m_unit h3 a')
      elements.each do |ele|
        links << ele.get_attribute('href')
      end
    
      next_url = current_page.at('.pagination .next_page').get_attribute('href')
      unless next_url
        break
      end
    end

    links.each do |link|
      get_product('http://eiga.com' + link)
    end
  end

  def self.get_product(link)
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('h1').inner_text
    image_url = page.at('.pictBox img').get_attribute('src') if page.at('.pictBox img')
    director = page.at('.staffBox .f a').inner_text if page.at('.staffBox .f a')
    detail = page.at('.outline p').inner_text if page.at('.outline p')
    open_date = page.at('.opn_date strong').get_attribute('content') if page.at('.opn_date strong')
    product = Product.where(title: title, image_url: image_url, director: director, detail: detail, open_date: open_date).first_or_initialize
    product.save
  end

end