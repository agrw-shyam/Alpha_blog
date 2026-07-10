class ArticleService < ApplicationService
  def self.call(author, params)
    # 1. Instantiates the object in-memory with the author's foreign key pre-filled
    article = author.articles.build(params)
    
    # 2. Attempts to save it to the database
    if article.save
      # Place your background jobs or side-effects here safely!
      # e.g., NotifySubscribersJob.perform_later(article)
      puts "🎉 Extra business logic executed!"
    end

    # 3. Always return the object (saved or unsaved) back to the controller
    article
  end
end