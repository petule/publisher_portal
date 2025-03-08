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
  User.find_or_create_by!(email: "publisher_#{publisher.id}@gmail.com", role: role,
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
author_1 = Author.where(first_name: 'prvni', last_name: 'Novar',
                        content: 'Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputa').first_or_create!
author_2 = Author.where(first_name: 'Druhy', last_name: 'Test',
                        content: 'Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputa').first_or_create!
author_3 = Author.where(first_name: 'Treti', last_name: 'Kecal',
                        content: 'Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputa').first_or_create!
author_4 = Author.where(first_name: 'Ctvrty', last_name: 'Dvorak',
                        content: 'Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputa').first_or_create!

puts 'creating publishers and default users'
publisher_1 = Publisher.where(title: 'prvni', url: 'prvni', active: true,
                               content: 'Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputa' ).first_or_create!
default_user(publisher_1)
publisher_2 = Publisher.where(title: 'Druhy', url: 'druhy', active: true,
                               content: 'Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputa' ).first_or_create!
default_user(publisher_2)
publisher_3 = Publisher.where(title: 'Treti', url: 'treti', active: true,
                               content: 'Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputa' ).first_or_create!
default_user(publisher_3)
publisher_4 = Publisher.where(title: 'Ctvrty', url: 'ctvrty', active: true,
                               content: 'Aliquam erat volutpat. Maecenas aliquet accumsan leo. Nullam feugiat, turpis at pulvinar vulputa' ).first_or_create!
default_user(publisher_4)

puts 'creating default users'
User.find_or_create_by!(email: 'petra.holzknechtova@seznam.cz', first_name: 'petra', last_name: 'admin', role: :admin) do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
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

