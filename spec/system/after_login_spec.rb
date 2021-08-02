require 'rails_helper'

describe "ログイン後のテスト" do
  let!(:user) { create(:user) }
  let!(:post) { create(:post) }

  before do
    visit root_path
    within(".sign_in_modal") do
      fill_in "user[email]", with: user.email
      fill_in "user[password]", with: user.password
      click_button "Log in"
    end
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


  context "ユーザー詳細画面" do
    let!(:user2) { create(:user)}
    let!(:post2) {Post.create(user_id: user2.id, title: Faker::Lorem.characters(number: 5), body: Faker::Lorem.characters(number: 20), type: 1) }

    it "他のユーザーの詳細画面に遷移するか" do
      visit posts_path
      first('.user-box-link').click
      expect(current_path).to eq user_path(user2.id)
    end
    it "投稿が表示されているか" do
      visit user_path(user2.id)
      expect(page).to have_content post2.title
    end
  end

  context "ログアウト" do
    it "ログアウトのリンクを押したらログアウトするか" do
      click_on "ログアウト"
      expect(current_path).to eq root_path
      expect(page).to have_content "ログアウトしました"
    end
    it "ログアウトした際にヘッダーの表示が変わっているか" do
      click_on "ログアウト"
      expect(page).not_to have_content "マイページ"
    end
  end


  context "プロフィールの編集" do
    let!(:user2) { create(:user)}

    it "自分のプロフィール編集画面に遷移できるか" do
      visit user_path(user.id)
      find(".edit-link").click
      expect(current_path).to eq edit_user_path(user.id)
    end
    it "プロフィールを編集できるか" do
      visit edit_user_path(user.id)
      fill_in "user[name]", with: "テスト名前"
      fill_in "user[age]", with: 99
      fill_in "user[profession]", with: "エンジニア"
      fill_in "user[introduction]", with: "テストです"
      click_button "保存"
      expect(current_path).to eq user_path(user.id)
      expect(page).to have_content "テスト名前"
      expect(page).to have_content 99
      expect(page).to have_content "エンジニア"
      expect(page).to have_content "テストです"
    end
    it "他の人のプロフィール編集画面に遷移できないか" do
      visit edit_user_path(user2.id)
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
    it "自分の投稿を削除できるか" do
      expect {
        visit post_path(1)
        click_on "削除する"
      }.to change { Post.count}.by(-1)
      expect(current_path).to eq posts_path
    end
  end


  context "コメント機能" do
    it "コメントを送信できるか" do
      visit post_path(1)
      fill_in "comment[content]", with: "テストコメント"
      # click_button "コメントする"
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


  context "タイムライン機能" do
    it "タイムライン画面に遷移するか" do
      click_on "タイムライン"
      expect(current_path).to eq timelines_path
    end
    # it "投稿は表示されるか" do
    #   click_on "タイムライン"
    #   expect(page).to have_content user.name
    # end
  end


  context "メッセージ機能" do
    let!(:user2) { create(:user)}

    it "メッセージ画面に遷移するか" do
      click_on "メッセージ"
      expect(current_path).to eq rooms_path
    end
    it "UserRoomが作られ、メッセージができる状態か" do
       expect {
        visit room_path(2)
       }.to change { UserRoom.count }.by(2)
    end
    it "Roomが作られメッセージができる状態か" do
       expect {
        visit room_path(2)
       }.to change { Room.count }.by(1)
    end
    # it "メッセージが送信できるか" do
    #   visit room_path(2)
    #   expect(page).to have_content "送信"
    # end
  end


  context "通知機能" do
    it "通知画面に遷移するか"do
      click_on "通知"
      expect(current_path).to eq notifications_path
    end
  end


  context "プレビュー機能" do
    let!(:user2) { create(:user)}
    let!(:post2) {Post.create(user_id: user2.id, title: Faker::Lorem.characters(number: 5), body: Faker::Lorem.characters(number: 20), type: 1) }

    it "投稿詳細画面に遷移したらプレビュー数は増えるか" do
      expect {
        visit post_path(post.id)
      }.to change { post.previews.count }.by(1)
    end
    it "同じ投稿の詳細画面に遷移した場合、プレビュー数は変わらないか" do
      visit post_path(post.id)
      expect {
        visit post_path(post.id)
      }.not_to change { post.previews.count }
    end
    it "閲覧した事がある投稿の場合、最終閲覧日が表示されるか" do
      visit post_path(post2.id)
      visit posts_path
      expect(page).to have_content "前に閲覧"
    end
  end


  context "カレンダー機能" do
     let!(:post2) {Post.create(user_id: user.id, title: Faker::Lorem.characters(number: 5), body: Faker::Lorem.characters(number: 20), type: 2) }
     let!(:plan) { Plan.create(user_id: user.id, post_id: post2.id, start_time: post2.created_at) }

    it "カレンダー画面に遷移するか" do
      visit user_path(user.id)
      find(".plan-link").click
      expect(current_path).to eq plans_path
    end
    it "やってみたで投稿した場合、カレンダーに自動で反映されるか" do
      visit plans_path
      expect(page).to have_content post2.title
      expect(page).to have_content "Clear"
    end
  end


  context "リツイート機能" do
    it "投稿をリツイートできるか" do
      # expect {
        # visit post_path(1)
        # first('.fa-retweet').click
        # sleep 1.0
      # }.to change { Repost.count }.by(1)
    end
  end


end