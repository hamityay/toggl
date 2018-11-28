# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# to update manually duration for timers - for saved timers, before writed down callback 
# Timer.all.each do |t|
#   d = (t.finish - t.start) / 60.0
#   t.update(duration: d)
# end

fun_array = %w[İyi Güzel Hoş Eğlenceli Sıkıcı İlginç Sürükleyici Zevkli Heycan_Verici]

type_array = %w[Spor İş Toplantı Müzik Konser Futbol Basketbol Tenis Kodlama Kişisel_Gelişim
    Okuma Film Gezi Seminer Proje]

type_array.each do |type_name|
  Type.create(name: type_name)
end

type_ids = Type.all.ids.sort

for i in 1..10
  u = User.new
  u.username = "user_" + i.to_s
  u.email = i.to_s + "@user.net"
  u.password = "12341234"
  u.password_confirmation = "12341234"
  if i % 3 == 0
    u.is_admin = true
  end
  u.save
end

user_ids = User.all.ids.sort

user_ids.each do |user_id|
  for i in 1..10
    start_date = DateTime.now - i.days
    finish_date = start_date + (1 + Random.rand(30)).minutes
    type = Type.find type_ids.sample
    info = type.name + " " + fun_array.sample
    t = Timer.create(info: info, start: start_date, finish: finish_date, user_id: user_id, type_id: type.id)
  end
end
