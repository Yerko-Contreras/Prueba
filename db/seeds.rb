# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


10.times do
    user = User.create(
        email: Faker::Internet.email,
        password: Faker::Internet.password(min_length: 6),
        phone: '12345678',
        admin: false,
        address: Faker::Address.street_address,
        username: Faker::Name.name
    )

    3.times do
        user.turnos.create(
            address_in: Faker::Address.street_address,
            address_out: Faker::Address.street_address,
            capacity: rand(1..10),
            route: ["ida", "vuelta"].sample,
            day: ["LUNES", "MARTES" ,"MIERCOLES" ,"JUEVES", "VIERNES", "SABADO","DOMINGO"].sample,
            hour: "#{rand(10..20)}:#{rand(10..59)}",
            user_id: user.id.to_i
        )
    end

admin = User.create(
    email: 'admin_nicole@admin.iic',
    password: 'admin1234',
    username: 'Admin Nicole',
    address: 'Admin Address 1234',
    phone: '12345678',
    admin: true
)
end