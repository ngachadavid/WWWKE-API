class ArticlesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
  
    def index
      articles = Article.all
      render json: articles, status: :ok
    end
  
    def show
      article = Article.find(params[:id])
      render json: article, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Article not found' }, status: :not_found
    end
  
    def create
      article = current_user.articles.new(article_params)
  
      if article.save
        render json: article, status: :created
      else
        render json: { errors: article.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      article = current_user.articles.find(params[:id])
  
      if article.update(article_params)
        render json: article, status: :ok
      else
        render json: { errors: article.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Article not found' }, status: :not_found
    end
  
    def destroy
      article = current_user.articles.find(params[:id])
      article.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Article not found' }, status: :not_found
    end
  
    private
  
    def article_params
      params.require(:article).permit(:title, :content, :image)
    end
  end
  