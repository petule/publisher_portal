# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
def put_default_prices(ebook, discount)
  czk = Currency.by_code('czk').first
  eur = Currency.by_code('eur').first
  usd = Currency.by_code('usd').first
  #old
  base_price = (20..315).to_a.sample
  EbookPrice.where(base_price: base_price, price: calc_price(base_price, discount), currency_id: czk.id,
                   discount_id: discount ? discount.id : nil, ebook_id: ebook.id, valid_from: Date.today - 10.days,
                   valid_to: Date.today - 4.days).first_or_create!
  eur_price = calc_from_rate(base_price, eur)
  EbookPrice.where(base_price: eur_price, price: calc_price(eur_price, discount), currency_id: eur.id,
                   discount_id: discount ? discount.id : nil, ebook_id: ebook.id, valid_from: Date.today - 10.days,
                   valid_to: Date.today - 4.days).first_or_create!
  usd_price = calc_from_rate(base_price, usd)
  EbookPrice.where(base_price: usd_price, price: calc_price(usd_price, discount), currency_id: usd.id,
                   discount_id: discount ? discount.id : nil, ebook_id: ebook.id, valid_from: Date.today - 10.days,
                   valid_to: Date.today - 4.days).first_or_create!

  #actual
  base_price = (20..315).to_a.sample
  EbookPrice.where(base_price: base_price, price: calc_price(base_price, discount), currency_id: czk.id,
                   discount_id: discount ? discount.id : nil, ebook_id: ebook.id, valid_from: Date.today - 5.days,
                   active: true).first_or_create!
  eur_price = calc_from_rate(base_price, eur)
  EbookPrice.where(base_price: eur_price, price: calc_price(eur_price, discount), currency_id: eur.id,
                   discount_id: discount ? discount.id : nil, ebook_id: ebook.id, valid_from: Date.today - 5.days,
                   active: true).first_or_create!
  usd_price = calc_from_rate(base_price, usd)
  EbookPrice.where(base_price: usd_price, price: calc_price(usd_price, discount), currency_id: usd.id,
                   discount_id: discount ? discount.id : nil, ebook_id: ebook.id, valid_from: Date.today - 5.days,
                   active: true).first_or_create!
end

def calc_price(base_price, discount)
  return base_price unless discount

  base_price - discount.size * (base_price/100)
end

def calc_from_rate(price, currency)
  exchange_rate = currency.actual_exchange_rate
  #ExchangeRate.where(currency_id: usd.id, ex_rate: 23.660, quantity: 1, valid_from: Date.today - 10.days, valid_to: nil, actual: true)
  (price/exchange_rate.ex_rate) * exchange_rate.quantity
end

def default_user(publisher, role = :user)
  User.find_or_create_by!(email: "publisher_#{publisher.id}@gmail.com", role: role, publisher: publisher,
    first_name: publisher.title, last_name: "#{publisher.title}_lastname") do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
  end
end

puts 'creating currencies'
eur = Currency.where(code: 'eur').first_or_create!
usd = Currency.where(code: 'usd').first_or_create!
czk = Currency.where(code: 'czk').first_or_create!

puts 'creating languages '
lang_cs = Language.where(code: 'cs', url: 'neco.cz', active: true, name: 'česky', currency_id: czk.id).first_or_create
lang_sk = Language.where(code: 'sk', url: 'neco.sk', active: true, name: 'slovensky', currency_id: eur.id).first_or_create


puts 'creating authors'
5.times do |i|
  content = "#{i} Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputa"
  author_1 = Author.where(first_name: "prvni #{i}", last_name: "Novar #{i}", content: content).first_or_create!
  author_2 = Author.where(first_name: "Druhy #{i}", last_name: "Test #{i}", content: content).first_or_create!
  author_3 = Author.where(first_name: "Treti #{i}", last_name: "Kecal #{i}", content: content).first_or_create!
  author_4 = Author.where(first_name: "Ctvrty #{i}", last_name: "Dvorak #{i}", content: content).first_or_create!
end
content = "KUK Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputa"
author_1 = Author.where(first_name: "prvni", last_name: "Novar", content: content, active: false).first_or_create!
author_2 = Author.where(first_name: "Druhy", last_name: "Test", content: content, active: false).first_or_create!
author_3 = Author.where(first_name: "Treti", last_name: "Kecal", content: content, active: false).first_or_create!
author_4 = Author.where(first_name: "Ctvrty", last_name: "Dvorak", content: content, active: false).first_or_create!



puts 'creating publishers and default users'
publisher_1 = Publisher.where(title: 'prvni', url: 'prvni.com', active: true, email: 'publisher1.gmail.com',
                               content: 'Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputa' ).first_or_create!
default_user(publisher_1)
publisher_2 = Publisher.where(title: 'Druhy', url: 'druhy.com', active: true, email: 'publisher2.gmail.com',
                               content: 'Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputa' ).first_or_create!
default_user(publisher_2)
publisher_3 = Publisher.where(title: 'Treti', url: 'treti.com', active: true, email: 'publisher3.gmail.com',
                               content: 'Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputa' ).first_or_create!
default_user(publisher_3)
publisher_4 = Publisher.where(title: 'Ctvrty', url: 'ctvrty.com', active: true, email: 'publisher4.gmail.com',
                               content: 'Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputa' ).first_or_create!
default_user(publisher_4)

puts 'creating default users'
User.find_or_create_by!(email: 'petra.holzknechtova@seznam.cz', first_name: 'petra', last_name: 'admin', role: :admin) do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
end

User.find_or_create_by!(email: 'admin@example.com', first_name: 'Admin', last_name: 'User', role: :admin) do |user|
  user.password = 'adminpassword123'
  user.password_confirmation = 'adminpassword123'
end

# Vytvoření administrátora nakladatelství (publisher_admin)
User.find_or_create_by!(email: 'publisheradmin@example.com', first_name: 'Publisher', last_name: 'Admin', role: :publisher_admin) do |user|
  user.password = 'publisheradminpassword123'
  user.password_confirmation = 'publisheradminpassword123'
end

# Vytvoření Data Master (data_master)
User.find_or_create_by!(email: 'datamaster@example.com', first_name: 'Data', last_name: 'Master', role: :data_master) do |user|
  user.password = 'datamasterpassword123'
  user.password_confirmation = 'datamasterpassword123'
end

# Vytvoření uživatele (user)
User.find_or_create_by!(email: 'user@example.com', first_name: 'User', last_name: 'Example', role: :user) do |user|
  user.password = 'userpassword123'
  user.password_confirmation = 'userpassword123'
end


puts 'creating exchange rates'
#actual
ExchangeRate.where(currency_id: usd.id, ex_rate: 23.660, quantity: 1, valid_from: Date.today - 10.days, valid_to: nil, active: true).first_or_create!
ExchangeRate.where(currency_id: eur.id, ex_rate: 21.734, quantity: 1, valid_from: Date.today - 5.days, valid_to: nil, active: true).first_or_create!
ExchangeRate.where(currency_id: czk.id, ex_rate: 1, quantity: 1, valid_from: Date.today - 4.days, valid_to: nil, active: true).first_or_create!

#old
ExchangeRate.where(currency_id: usd.id, ex_rate: 24.660, quantity: 1, valid_from: Date.today - 15.days, valid_to: Date.
  today - 9.days).first_or_create!
ExchangeRate.where(currency_id: eur.id, ex_rate: 21.734, quantity: 1, valid_from: Date.today - 10.days, valid_to: Date.today - 4.days).first_or_create!

puts 'creating category types'
[lang_cs, lang_sk].each do |lang|
  CategoryType.where(name: "e-knihy #{lang.code}", language_id: lang.id, code: 'e-books', active: true).first_or_create!
  CategoryType.where(name: "audio knihy #{lang.code}", language_id: lang.id, code: 'audio-books', active: true).first_or_create!
end

puts 'creating testing categories'
[lang_cs, lang_sk].each do |lang|
  category_type = CategoryType.ebooks(lang.code)
  first_category = Category.where(name: "prvni #{lang.code}", language_id: lang.id, url: 'prvni', active: true,
                                  title: "prvni #{lang.code}",
                                  content: "Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputate, erat libero tristique tellus, nec bibendum odio risus sit amet ante. Nam sed tellus id magna elementum tincidunt. Proin in tellus sit amet nibh dignissim sagittis. Praesent vitae arcu tempor neque lacinia pretium. Mauris suscipit, ligula sit amet pharetra semper, nibh ante cursus purus, vel sagittis velit mauris vel metus. Sed ac dolor sit amet purus malesuada congue. Fusce tellus. Nulla non lectus sed nisl molestie malesuada. Proin mattis lacinia justo. Integer imperdiet lectus quis justo. Suspendisse sagittis ultrices augue. Etiam neque. Mauris suscipit, ligula sit amet pharetra semper, nibh ante cursus purus, vel sagittis velit mauris vel metus.",
                                  category_type_id: category_type.id).first_or_create!

  second_category = Category.where(name: "druhy #{lang.code}", language_id: lang.id, url: 'druhy', active: true,
                                   title: "druhy #{lang.code}", favourite: true,
                                   content: "Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputate, erat libero tristique tellus, nec bibendum odio risus sit amet ante. Nam sed tellus id magna elementum tincidunt. Proin in tellus sit amet nibh dignissim sagittis. Praesent vitae arcu tempor neque lacinia pretium. Mauris suscipit, ligula sit amet pharetra semper, nibh ante cursus purus, vel sagittis velit mauris vel metus. Sed ac dolor sit amet purus malesuada congue. Fusce tellus. Nulla non lectus sed nisl molestie malesuada. Proin mattis lacinia justo. Integer imperdiet lectus quis justo. Suspendisse sagittis ultrices augue. Etiam neque. Mauris suscipit, ligula sit amet pharetra semper, nibh ante cursus purus, vel sagittis velit mauris vel metus.",
                                   category_type_id: category_type.id).first_or_create!

  third_category = Category.where(name: "treti #{lang.code}", language_id: lang.id, url: 'treti', active: true,
                                  title: "treti #{lang.code}", favourite: true,
                                  content: "Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputate, erat libero tristique tellus, nec bibendum odio risus sit amet ante. Nam sed tellus id magna elementum tincidunt. Proin in tellus sit amet nibh dignissim sagittis. Praesent vitae arcu tempor neque lacinia pretium. Mauris suscipit, ligula sit amet pharetra semper, nibh ante cursus purus, vel sagittis velit mauris vel metus. Sed ac dolor sit amet purus malesuada congue. Fusce tellus. Nulla non lectus sed nisl molestie malesuada. Proin mattis lacinia justo. Integer imperdiet lectus quis justo. Suspendisse sagittis ultrices augue. Etiam neque. Mauris suscipit, ligula sit amet pharetra semper, nibh ante cursus purus, vel sagittis velit mauris vel metus.",
                                  category_type_id: category_type.id, category_id: second_category.id).first_or_create!

  fifth_category = Category.where(name: "ctvrty #{lang.code}", language_id: lang.id, url: 'ctvrty', active: true,
                                  title: "ctvrty #{lang.code}", favourite: true,
                                  content: "Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputate, erat libero tristique tellus, nec bibendum odio risus sit amet ante. Nam sed tellus id magna elementum tincidunt. Proin in tellus sit amet nibh dignissim sagittis. Praesent vitae arcu tempor neque lacinia pretium. Mauris suscipit, ligula sit amet pharetra semper, nibh ante cursus purus, vel sagittis velit mauris vel metus. Sed ac dolor sit amet purus malesuada congue. Fusce tellus. Nulla non lectus sed nisl molestie malesuada. Proin mattis lacinia justo. Integer imperdiet lectus quis justo. Suspendisse sagittis ultrices augue. Etiam neque. Mauris suscipit, ligula sit amet pharetra semper, nibh ante cursus purus, vel sagittis velit mauris vel metus.",
                                  category_type_id: category_type.id, category_id: second_category.id).first_or_create!

  sixth_category = Category.where(name: "paty #{lang.code}", language_id: lang.id, url: 'paty', active: true,
                                  title: "paty #{lang.code}",
                                  content: "Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputate, erat libero tristique tellus, nec bibendum odio risus sit amet ante. Nam sed tellus id magna elementum tincidunt. Proin in tellus sit amet nibh dignissim sagittis. Praesent vitae arcu tempor neque lacinia pretium. Mauris suscipit, ligula sit amet pharetra semper, nibh ante cursus purus, vel sagittis velit mauris vel metus. Sed ac dolor sit amet purus malesuada congue. Fusce tellus. Nulla non lectus sed nisl molestie malesuada. Proin mattis lacinia justo. Integer imperdiet lectus quis justo. Suspendisse sagittis ultrices augue. Etiam neque. Mauris suscipit, ligula sit amet pharetra semper, nibh ante cursus purus, vel sagittis velit mauris vel metus.",
                                  category_type_id: category_type.id, category_id: third_category.id).first_or_create!


  category_type_audio = CategoryType.audio_books(lang.code)
  first_category_audio = Category.where(name: "prvni audio #{lang.code}", language_id: lang.id, url: 'prvni-audio', active: true,
                                        category_type_id: category_type_audio.id).first_or_create!
  second_category_audio = Category.where(name: "druhy audio #{lang.code}", language_id: lang.id, url: 'druhy-audio', active: true,
                                         category_type_id: category_type_audio.id).first_or_create!
  third_category_audio = Category.where(name: "treti audio #{lang.code}", language_id: lang.id, url: 'treti-audio', active: true,
                                        category_type_id: category_type_audio.id, category_id: second_category_audio.id).first_or_create!
  fifth_category_audio = Category.where(name: "ctvrty audio #{lang.code}", language_id: lang.id, url: 'ctvrty-audio', active: true,
                                        category_type_id: category_type_audio.id, category_id: second_category_audio.id).first_or_create!
  sixth_category_audio = Category.where(name: "paty audio #{lang.code}", language_id: lang.id, url: 'paty-audio', active: true,
                                        category_type_id: category_type_audio.id, category_id: third_category_audio.id).first_or_create!
end
