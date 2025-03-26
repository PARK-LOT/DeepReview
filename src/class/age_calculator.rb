require 'date'

class AgeCalculator
  # 誕生日から年齢を計算するメソッド
  # @param birthday [String, Date] 誕生日 (YYYY-MM-DD形式の文字列またはDateオブジェクト)
  # @param reference_date [Date] 基準日 (デフォルトは今日)
  # @return [Integer] 年齢
  def self.calculate_age(birthday, reference_date = Date.today)
    # 文字列の場合はDateオブジェクトに変換
    birth_date = birthday.is_a?(Date) ? birthday : Date.parse(birthday)
    
    # 年齢の計算
    age = reference_date.year - birth_date.year
    
    # 今年の誕生日がまだ来ていない場合は1歳引く
    if reference_date.month < birth_date.month || 
       (reference_date.month == birth_date.month && reference_date.day < birth_date.day)
      age -= 1
    end
    
    age
  end
  
  # 次の誕生日までの日数を計算するメソッド
  # @param birthday [String, Date] 誕生日 (YYYY-MM-DD形式の文字列またはDateオブジェクト)
  # @param reference_date [Date] 基準日 (デフォルトは今日)
  # @return [Integer] 次の誕生日までの日数
  def self.days_until_next_birthday(birthday, reference_date = Date.today)
    birth_date = birthday.is_a?(Date) ? birthday : Date.parse(birthday)
    
    # 今年の誕生日
    this_year_birthday = Date.new(reference_date.year, birth_date.month, birth_date.day)
    
    # 今年の誕生日が過ぎている場合は来年の誕生日
    if this_year_birthday < reference_date
      this_year_birthday = Date.new(reference_date.year + 1, birth_date.month, birth_date.day)
    end
    
    # 日数の計算
    (this_year_birthday - reference_date).to_i
  end
  
  # 誕生日の曜日を返すメソッド
  # @param birthday [String, Date] 誕生日 (YYYY-MM-DD形式の文字列またはDateオブジェクト)
  # @return [String] 誕生日の曜日 (日本語)
  def self.birthday_day_of_week(birthday)
    birth_date = birthday.is_a?(Date) ? birthday : Date.parse(birthday)
    
    # 曜日の配列（0:日曜日, 1:月曜日, ..., 6:土曜日）
    days_of_week = %w[日曜日 月曜日 火曜日 水曜日 木曜日 金曜日 土曜日]
    days_of_week[birth_date.wday]
  end
end