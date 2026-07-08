class ArticleService < ApplicationService


  def create(author, article_params)

    @article = author.articles.build(article_params) #.create
    
    if @article.save
      # 2. Put extra business logic here (e.g., NotifySubscribersJob.perform_later(@article))
      puts "🎉 Business logic executed inside Service Object!"
      @article
    else
      false
    end
  end
end