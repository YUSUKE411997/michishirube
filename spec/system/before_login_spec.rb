require 'rails_helper'

describe 'ユーザーログイン前のテスト' do
  let!(:user) { create(:user) }
  let!(:post) { create(:post) }
  let!(:tag) { create(:tag) }
  let!(:tag_map) { create(:tag_map) }
  let!(:comment) { create(:comment) }

  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it '投稿一覧のリンクがあるか' do
        expect(page).to have_link '投稿一覧', href: posts_path
      end
      it '新規登録のリンクがあるか' do
        expect(page).to have_button 'Sign up'
      end
      it 'ログインのリンクがあるか' do
        expect(page).to have_button 'Log in'
      end
      it 'ゲストログインのリンクがあるか' do
        expect(page).to have_link 'ゲストログイン', href: users_guest_sign_in_path
      end
    end
  end

  describe "ログインのテスト" do
    before do
      visit root_path
    end

    context "ログインのテスト" do
      it "新規登録はできるか" do
        within(".sign_up_modal") do
          fill_in "user[name]", with: "テスト"
          fill_in "user[email]", with: "rspec@rspec"
          fill_in "user[password]", with: "rspecrspec"
          fill_in "user[password_confirmation]", with: "rspecrspec"
          click_button "Sign up"
        end
        expect(current_path).to eq posts_path
      end
      it 'ログインできるか' do
        within(".sign_in_modal") do
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
        click_button "Log in"
        end
        expect(current_path).to eq posts_path
      end
    end
  end
  

  describe "投稿一覧画面のテスト" do
    context '投稿一覧画面の表示' do
      it '投稿一覧画面に遷移するか' do
        click_on '投稿一覧'
        expect(current_path).to eq posts_path
      end

      before do
        visit posts_path
      end
      it "タグ一覧を表示するボタンがあるか" do
        expect(page).to have_button 'タグ一覧'
      end
      it "タグの名前が正しく表示されていてリンクになっているか" do
        expect(page).to have_link tag.tag_name, href: tag_posts_path(tag.id)
      end
      it "投稿が表示されているか" do
        expect(page).to have_content user.name
        expect(page).to have_content post.title
        expect(page).to have_content post.body
        expect(page).to have_content post.type
      end
    end
    

    context "投稿詳細画面のテスト" do
      before do
        visit posts_path
      end
      it "投稿詳細画面へ遷移するか" do
        find(".post-link").click
        expect(current_path).to eq post_path(post)
      end
      it "コメントは表示されているか" do
        find(".post-link").click
        expect(current_path).to eq post_path(post)
        expect(page).to have_content comment.content
      end
    end


  end
end