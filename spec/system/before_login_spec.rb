require 'rails_helper'

describe 'ユーザーログイン前のテスト' do
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
        click_button "新規登録"
        # expect(page).to have_link 'Sign up'
      end
    end
  end
end