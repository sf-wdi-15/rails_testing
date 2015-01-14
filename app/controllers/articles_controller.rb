class ArticlesController < ApplicationController
  before_filter :find_article, except: [:index, :new, :create]
  before_filter :logged_in? 
  def index
    @articles = Article.all
    @articles.each do |article|
      if article.content.length > 500
        article.get_keywords  
      end
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.create(article_params)
    redirect_to article_path(@article.id)
  end

  def show
    if @article.content.length > 500
      @article.get_keywords  
    end
  end

  def edit
  end

  def update
    @article.update(article_params)
    redirect_to article_path(@article.id)
  end

  def delete
    @article.destroy
    redirect_to articles_path
  end


  private

    def find_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :author, :content)
    end
end
