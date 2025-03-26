# age_calculator を require して、AgeCalculator クラスを使ってみる
require './src/class/age_calculator.rb'

birthday = "1990-05-15"
  
# 年齢の計算
age = AgeCalculator.calculate_age(birthday)
puts "#{birthday} 生まれの人は#{age}歳です"
