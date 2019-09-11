class UsersController < ApplicationController
  def login_form
  end

  def login
    @user = User.find_by(
      email: params[:email],
      password: params[:password]
      )

    if @user
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to("/posts/index")
    else
      @email = params[:email]
      @password = params[:password]
      @error_message = "メールアドレスまたはパスワードが間違っています"
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/")
  end

  def signup_form
    @user = User.new
  end

  def signup
    #デフォルト画像をランダムに設定
    default_image = "default_image" + Random.new().rand(1..3).to_s + ".jpg"

    @user = User.new(
      email: params[:email],
      password: params[:password],
      name: params[:name],
      image_name: default_image
      )

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "新規登録しました"
      redirect_to("/users/#{@user.id}/show")
    else
      render("/users/signup_form")
    end
  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find_by(id: params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}/show")
    else
      render("users/edit")
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: @user.id)
  end

  def likes
    @likes = Like.where(user_id: params[:id])
    @user = User.find_by(id: params[:id])
  end

end
