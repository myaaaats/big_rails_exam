class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :login, only: [:new, :edit, :show, :destroy]

  def index
    @tweets = Tweet.all
  end

  def new
    if params[:back]
      @tweet = Tweet.new(tweet_params)
    else
      @tweet = Tweet.new
    end
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    #@tweet.user_email = current_user.email
    if @tweet.save
      ContactMailer.contact_mail(current_user.email, @tweet).deliver
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to tweets_path, notice: "ブログを作成しました！"
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end

  def show
#    @tweet = Tweet.find(params[:id])
#    @tweet.user_id = current_user.id
    @favorite = current_user.favorites.find_by(tweet_id: @tweet.id)
  end

  def edit
#    @tweet = Tweet.find(params[:id])
  end

  def update
#    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)
      redirect_to tweets_path, notice: "ブログを編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path, notice:"ブログを削除しました！"
  end

  def confirm
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    render :new if @tweet.invalid?
  end

  private
    def tweet_params
      params.require(:tweet).permit(:content)
    end

    # idをキーとして値を取得するメソッド
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def login
      redirect_to new_user_path unless logged_in?
    end
end
