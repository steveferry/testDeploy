class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.paginate(page: params[:page])
    @comment = Comment.new
  end
  
  def index
    @posts = Post.where(draft: false).paginate(page: params[:page])
  end
  
  def new
    @post = Post.new
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def create
    @post = Post.new(getParams)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(getParams)
      redirect_to @post
    else
      render 'edit'
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end
  
  def drafts
    @posts = Post.where(draft: true).paginate(page: params[:page])
    render 'index'
  end
  
  private
  
  def getParams
    params[:post].permit(:title,:content,:draft)
  end
end
