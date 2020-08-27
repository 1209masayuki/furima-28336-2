require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "ニックネーム、メールアドレス、パスワード、パスワード確認、苗字全角、名前全角、苗字カナ全角、名前カナ全角、生年月日が存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it 'ニックネームが40文字以下で登録できる' do
        @user.nickname = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        expect(@user).to be_valid
      end
      it 'パスワードが6文字以上あれば登録できる' do
        @user.password = "000000"
        @user.password_confirmation = "000000"
        expect(@user).to be_valid
      end
      it '苗字（全角）が全角文字だけが存在すれば登録できる' do
        @user.first_name = "根もト"
        expect(@user).to be_valid
      end
      it '名前（全角）が全角文字だけが存在すれば登録できる' do
        @user.last_name = "雅ゆキ"
        expect(@user).to be_valid
      end
      it '苗字カナ（全角）が全角でカタカナのみが存在すれば登録できる' do
        @user.first_name_kana = "ネモト"
        expect(@user).to be_valid
      end
      it '名前カナ（全角）が全角でカタカナのみが存在すれば登録できる' do
        @user.first_name_kana = "マサユキ"
        expect(@user).to be_valid
      end
    end
    context '新規登録がうまくいかないとき' do
      it "ニックネームが空だと登録できない" do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "ニックネームがが41文字以上だと登録できない" do
        @user.nickname = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname is too long (maximum is 40 characters)")
      end
      it "メールアドレスが空では登録できない" do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "重複したメールアドレスは登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "生年月日が空では登録できない" do
        @user.birth_date = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
      it "パスワードが空では登録できない" do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "パスワードが存在してもパスワード確認が空だと登録できない" do
        @user.password = "aaaaaa"
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "パスワードが5文字以下だと登録できない" do
        @user.password = "00000"
        @user.password_confirmation = "00000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "苗字（全角）が空では登録できない" do
        @user.first_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '苗字（全角）が全角の文字以外が存在すると登録できない' do
        @user.first_name = "mOt0"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name First name Full-width characters")
      end
      it "名前（全角）が空では登録できない" do
        @user.last_name = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it '名前（全角）が全角の文字以外が存在すると登録できない' do
        @user.last_name = "mOt0"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name Last name Full-width characters")
      end
      it "苗字カナ（全角）が空では登録できない" do
        @user.first_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it '苗字カナ（全角）が全角カタカナ以外が存在すると登録できない' do
        @user.first_name_kana = "根もtO0"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana First name kana Full-width katakana characters")
      end
      it "名前カナ（全角）が空では登録できない" do
        @user.last_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it '名前カナ（全角）が全角カタカナ以外が存在すると登録できない' do
        @user.last_name_kana = "根もTo0"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana Last name kana Full-width katakana characters")
      end
    end
  end
end
