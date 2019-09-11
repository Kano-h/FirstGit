class PostsController < ApplicationController
  
  def index
    #oeder(:desc)で投稿が新しいものから並び替え
    @posts = Post.all.order(created_at: :desc)
  end
  
  def newpost_form
    @post = Post.new
  end
  
  def newpost
    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id
      )

    #投稿の保存チェック
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to("/posts/index")
    else
      @error_message = "投稿できません"
      render("/posts/newpost_form")
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = User.find_by(id: @post.user_id)
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]

    #編集の保存チェック
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
    end
  end

  def delete
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end

end
