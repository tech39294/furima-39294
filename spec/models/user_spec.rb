require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、名前(漢字)、名前(読み)、生年月日が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456a'
        @user.password_confirmation = '1234567a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '0000a'
        @user.password_confirmation = '0000a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end

      it '英字のみのパスワードでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数を両方含む必要があります')
      end

      it '数字のみのパスワードでは登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数を両方含む必要があります')
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'ああああああ'
        @user.password_confirmation = 'ああああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数を両方含む必要があります')
      end

      it 'familynameが空では登録できない' do
        @user.familyname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Familyname can't be blank")
        expect(@user.errors.full_messages).to include('Familyname は全角（漢字・ひらがな・カタカナ）で入力してください')
      end

      it 'familynameに半角文字が含まれていると登録できない' do
        @user.familyname = '佐々木a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Familyname は全角（漢字・ひらがな・カタカナ）で入力してください')
      end

      it 'firstnameが空では登録できない' do
        @user.firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname can't be blank")
        expect(@user.errors.full_messages).to include('Firstname は全角（漢字・ひらがな・カタカナ）で入力してください')
      end

      it 'firstnameに半角文字が含まれていると登録できない' do
        @user.firstname = 'りかa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Firstname は全角（漢字・ひらがな・カタカナ）で入力してください')
      end

      it 'familyname_kanaが空では登録できない' do
        @user.familyname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Familyname kana can't be blank")
        expect(@user.errors.full_messages).to include('Familyname kana は全角（カタカナ）で入力してください')
      end

      it 'familyname_kanaにカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
        @user.familyname_kana = 'あいこ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Familyname kana は全角（カタカナ）で入力してください')
      end

      it 'firstname_kanaが空では登録できない' do
        @user.firstname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Firstname kana can't be blank")
        expect(@user.errors.full_messages).to include('Firstname kana は全角（カタカナ）で入力してください')
      end

      it 'firstname_kanaにカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
        @user.firstname_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Firstname kana は全角（カタカナ）で入力してください')
      end

      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end
