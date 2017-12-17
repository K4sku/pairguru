require "faker"

Rails.logger = Logger.new(STDOUT)

Rails.logger.info "Creating users..."

20.times do |i|
  number = i.zero? ? "" : i + 1
  name = "user#{number}"
  email = "#{name}@example.com"
  next if User.exists?(email: email)
  User.create!(
    email: email,
    name: name,
    confirmed_at: Time.zone.now,
    password: "password"
  )
end

Rails.logger.info "Creating genres..."

%w(Action Comedy Sci-Fi War Crime
   Horror Sport Western Drama
   Musicial Romance Thriller).each do |genre|
  Genre.find_or_create_by!(name: genre)
end

movies = [
  {
    title: "Pulp Fiction",
    release_year: "1994"
  },
  {
    title: "Django",
    release_year: "2012"
  },
  {
    title: "Kill Bill",
    release_year: "2003"
  },
  {
    title: "Kill Bill 2",
    release_year: "2004"
  },
  {
    title: "Inglourious Basterds",
    release_year: "2009"
  },
  {
    title: "Godfather",
    release_year: "1972"
  },
  {
    title: "The Dark Knight",
    release_year: "2008"
  },
  {
    title: "Star Wars V",
    release_year: "1980"
  },
  {
    title: "Inception",
    release_year: "2010"
  },
  {
    title: "Deadpool",
    release_year: "2016"
  }
]

Rails.logger.info "Creating movies..."

genre_ids = Genre.pluck(:id)
if Movie.count < 100
  100.times do
    movie = movies.sample
    Movie.create!(
      title: movie[:title],
      description: Faker::Lorem.paragraph(5),
      genre_id: genre_ids.sample,
      released_at: Date.new(movie[:release_year].to_i)
    )
  end
end

Rails.logger.info "Creating comments..."

user_ids = User.pluck(:id)
Movie.all.each do |mov|
  rand_users = rand(5..User.count)
  rand_users_ids = user_ids.take(rand_users)
  i=0
  rand_users.times do
    Comment.create!(
               body: Faker::Lorem.paragraph(3),
               user_id: rand_users_ids[i],
               movie_id: mov.id
    )
    i += 1
  end
end