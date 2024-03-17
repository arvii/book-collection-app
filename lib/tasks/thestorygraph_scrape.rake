namespace :thestorygraph_scrape do
  task :scrape, [] => :environment do |t, args|
    service = StoryGraphScraper.new
    service.scrape
  end
end