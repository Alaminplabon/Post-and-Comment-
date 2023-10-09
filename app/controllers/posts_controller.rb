class PostsController < ApplicationController
  before_action :authenticate_user!,except: [:index]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource


  def index
    @posts = Post.all
  end

  def show
    # @post = Post.find(params[:id])
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @user= current_user
    @post.user=@user
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully deleted.'
  end

  private
  def set_post
    @post = Post.find_by(id: params[:id])
    unless @post
      redirect_to posts_url, alert: 'Post not found.'
    end
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
