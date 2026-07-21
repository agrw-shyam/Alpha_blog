class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /articles or /articles.json
  def index
    @articles = Article.all
    if params[:search].present?
    # Filter articles by checking if the title or description contains the search term
    # On MySQL/SQLite, 'LIKE' or 'ILIKE' is used for partial matching
    @articles = Article.where("title LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
  else
    # Default behavior: fetch all articles if no search query is typed
    @articles = Article.all
  end
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    # 1. Hand off all the creation work to our Service Object
    @article = ArticleService.call(current_user, article_params)

    # 2. Check the object state to determine the response routing
    respond_to do |format|
      if @article.persisted? # Returns true if it successfully saved to the database
        format.html { redirect_to @article, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        # If it failed, @article still holds all validation errors for the form view
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "Article was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @article.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    author = @article.user
    article_title = @article.title
    was_admin_deletion = current_user.admin? && current_user != author

    if @article.destroy
      # Trigger mailer if an admin deletes another user's article
      if was_admin_deletion
        UserMailer.article_deleted(author, article_title).deliver_now
      end

      flash[:notice] = "Article was successfully deleted."
      redirect_to articles_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :description, :image_upload)
    end

    def require_same_user
      if current_user != @article.user && !current_user.admin?
        flash[:alert] = "You can only edit or delete your own article"
        redirect_to @article
      end
    end
end