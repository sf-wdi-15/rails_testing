class ArticlesController < ApplicationController
  before_filter :find_user_article, only: [:destroy, :update, :edit]
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
    @new_article = Article.new
  end

  def create
    @article = current_user.articles.create(article_params)
    redirect_to article_path(@article.id)
  end

  def show
    find_article
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
    def find_user_article
      @article = current_user.articles.find_by({id: params[:id]})
      unless @article
        redirect_to user_path(current_user)
      else
        @article
      end
    end

    def find_article
      @article = Article.find_by({id: params[:id]})
    end

    def article_params
      params.require(:article).permit(:title,  :content)
    end
end
