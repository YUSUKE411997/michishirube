require 'rails_helper'

describe 'ユーザーログイン前のテスト' do
  let!(:user) { create(:user) }
  let!(:post) { create(:post) }
  
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it '投稿一覧のリンクがあるか' do
        expect(page).to have_link '投稿一覧', href: posts_path
      end
      it '新規登録のリンクがあるか' do
        expect(page).to have_content '新規登録'
        #expect(page).to have_link 'Sign up'
      end
      it 'ログインのリンクがあるか' do
        expect(page).to have_content 'ログイン'
      end
      it 'ゲストログインのリンクがあるか' do
        expect(page).to have_link 'ゲストログイン', href: users_guest_sign_in_path
      end
    end

    context '投稿一覧画面の表示' do
      it '投稿一覧画面に遷移するか' do
        click_on '投稿一覧'
        expect(current_path).to eq posts_path
      end
      
      before do
        visit posts_path
      end
      it '週間ランキング' do
        expect(page).to have_content '週間ランキング'
      end
      
    end
  end
end