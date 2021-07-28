require 'rails_helper'

describe "ログイン後のテスト" do
  let!(:user) { create(:user) }
  let!(:post) { create(:post) }

  before do
    visit root_path
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    click_button "Log in"
  end

  before do
    visit root_path
  end

  context "ヘッダーの表示が正しいか" do
    it "マイページを押して遷移するか" do
      click_on "マイページ"
      expect(current_path).to eq user_path(user.id)
    end
    it "タイムラインを押して遷移するか" do
      click_on "タイムライン"
      expect(current_path).to eq timelines_path
    end
    it "投稿一覧を押して遷移するか" do
      click_on "投稿一覧"
      expect(current_path).to eq posts_path
    end
    it "メッセージを押して遷移するか" do
      click_on "メッセージ"
      expect(current_path).to eq rooms_path
    end
    it "通知を押して遷移するか" do
      click_on "通知"
      expect(current_path).to eq notifications_path
    end
    it "ログアウトを押して遷移するか" do
      click_on "ログアウト"
      expect(current_path).to eq root_path
    end
  end

  before do
    visit posts_path
  end
  context "投稿機能" do
    it "投稿できるか" do
      expect {
      fill_in "post[title]", with: "テスト"
      fill_in "post[body]", with: "テスト"
      click_button "投稿"
      }.to change { Post.count }.by(1)
      expect(current_path).to eq posts_path
    end
    it "タグをつけて投稿し正しく表示されるか" do
      expect {
        fill_in "post[title]", with: "テスト"
        fill_in "post[body]", with: "テスト"
        fill_in "post[tag_name]", with: "テスト テスト２"
        click_button "投稿"
      }.to change { Tag.count }.by(2)
    end
  end

  context "検索機能" do
    it "空欄で検索した場合、検索できないか" do
      fill_in "word", with: ""
      click_on "検索"
      expect(current_path).to eq posts_path
    end
    it "検索したら該当の投稿が表示されるか" do
      fill_in "word", with: post.title
      click_on "検索"
      expect(current_path).to eq search_path
      expect(page).to have_content post.title
      expect(page).to have_content post.title
    end
  end

  # before do
  #   visit posts_path
  # end
  # context "リツイート機能" do
  #   it "投稿をリツイートできるか" do
  #     expect {
  #     first('.fa-retweet').click
  #     }.to change { Repost.count }.by(1)
  #   end
  # end

end