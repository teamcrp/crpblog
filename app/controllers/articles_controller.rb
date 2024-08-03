class ArticlesController < ApplicationController
  http_basic_authenticate_with name: "Afzal", password: "password", except: [:index, :show]
  
  def index
    @articles = Article.all
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  def new
    @article = Article.new
  end
  
  def create 
    @article = Article.new(article_params)
    
    if @article.save
      flash[:success] = "Great! Your article has been created!"
      redirect_to @article
    else
      flash.now[:error] = "Rats! Fix your mistakes, please."
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params)
      flash[:success] = "Your article has been successfully updated!"
      redirect_to @article
    else
      flash.now[:error] = "Oops! Correct your mistakes before editing."
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    article_title = @article.title
    @article.destroy
    flash[:success] = "The article '#{article_title}' has been deleted."
    redirect_to root_path, status: :see_other
  end
  
  private
  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
  
end
