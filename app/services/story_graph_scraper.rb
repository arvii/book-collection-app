require 'selenium-webdriver'

class StoryGraphScraper
  URL = 'https://app.thestorygraph.com/browse'

  def initialize
    @driver = setup_browser
  end

  def scrape
    scrape_record = ScrapeRecord.create(status: 'started', started_at: Time.current, scrape_source: 'The Story Graph')
    puts "Scraping The Story Graph..."

    start_time = Time.current
    @driver.get(URL)
    
    scroll_to_bottom # Did not limit the number of books to scrape because since the data will be available in the future, it is better to scrape all the books
    extract_documents
    
    finish_time = Time.current
    duration = (finish_time - start_time).to_i # Duration in seconds
    
    puts "Scraping Complete!"
    
    scrape_record.update(status: 'success', finished_at: finish_time, duration: duration)
  rescue => e
    scrape_record.update(status: 'failure', finished_at: Time.current, reason: e.message)
    puts "Scraping Failed: #{e.message}"
  ensure
    @driver.quit
  end


  private

  def setup_browser
    options = Selenium::WebDriver::Chrome::Options.new(args: ['--headless'])
    Selenium::WebDriver.for(:chrome, options: options)
  end

  def scroll_to_bottom
    last_height = @driver.execute_script("return document.body.scrollHeight")
    loop do
      @driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
      sleep 10 # Wait for the page to load
      new_height = @driver.execute_script("return document.body.scrollHeight")
      break if new_height == last_height
      last_height = new_height
    end
  end

  def extract_documents
    initial_window = @driver.window_handle
    
    book_elements = @driver.find_elements(css: '.book-pane-content')
    progress_bar = ProgressBar.create(title: "Scraping Books", total: book_elements.size, format: '%a %B %p%% %t')
    
    book_elements.each do |book_element|
      book_data = extract_initial_book_data(book_element)
      next unless book_data

      book_data.merge!(extract_book_other_details(book_data[:href]))

      create_book(book_data)

      @driver.switch_to.window(initial_window)
      progress_bar.increment  # Increment the progress bar after each book is processed
    end
  end

  #extract the initial data from the book element
  def extract_initial_book_data(book_element)
    title_element = book_element.find_element(css: '.book-title-author-and-series h1 a') rescue nil
    return if title_element.nil?

    {
      title: title_element.text.strip,
      author: book_element.find_element(css: '.book-title-author-and-series p:last-of-type a').text.strip,
      series: extract_series(book_element),
      year_of_publication: extract_year_of_publication(book_element),
      tags: extract_tags(book_element),
      href: title_element.attribute('href')
    }
  rescue Selenium::WebDriver::Error::NoSuchElementError
    nil
  end

  def extract_series(book_element)
    series_element = book_element.find_element(css: '.book-title-author-and-series p:first-of-type') rescue nil
    series_element ? series_element.text.strip : ""
  end

  def extract_year_of_publication(book_element)
    publication_info = book_element.find_element(css: '.toggle-edition-info-link').text.strip
    year_of_publication_match = publication_info.match(/first pub (\d{4})/)
    year_of_publication_match ? year_of_publication_match[1].to_i : nil
  end

  def extract_tags(book_element)
    tags_elements = book_element.find_elements(css: '.book-pane-tag-section span')
    tags_elements.map(&:text).reject(&:empty?)
  end

  def extract_book_other_details(href)
    @driver.execute_script("window.open('#{href}', '_blank');")
    new_tab = @driver.window_handles.last
    @driver.switch_to.window(new_tab)

    wait = Selenium::WebDriver::Wait.new(timeout: 10)

    # Wait for the description to load and then extract it
    description_element = wait.until { @driver.find_element(css: '.trix-content') }
    description = description_element.text.strip

    # Attempt to find and extract the average rating
    average_rating_element = @driver.find_element(css: 'span.average-star-rating') rescue nil
    average_rating = average_rating_element ? average_rating_element.text.strip : nil

    @driver.close # Close the current tab before switching back
    { description: description, average_rating: average_rating }
  end

  def create_book(book_data)
    author = Author.find_or_create_by(name: book_data[:author]) if book_data[:author].present?
    author_id = author.id if author.present?

    book = Book.find_or_initialize_by(title: book_data[:title], author_id: author_id, series: book_data[:series])

    book.year_of_publication = book_data[:year_of_publication].to_i unless book_data[:year_of_publication].nil?
    book.description = book_data[:description]
    book.average_rating = book_data[:average_rating].to_f unless book_data[:average_rating].nil?

    book.tags = book_data[:tags].map do |tag_name|
      Tag.find_or_create_by(name: tag_name)
    end

    book.save
  end
end
