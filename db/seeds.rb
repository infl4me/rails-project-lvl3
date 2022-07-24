# frozen_string_literal: true

if Rails.env.development?
  %w[development business ruby js job].each do |category|
    Category.find_or_create_by(name: category)
  end

  user = User.find_or_create_by(
    email: 'asd@asd.com',
    name: 'User One'
  )

  user_admin = User.find_or_create_by(
    email: 'hellpl4y@gmail.com',
    name: 'User Admin',
    admin: true
  )

  30.times do
    current_user = [user, user_admin].sample
    bulletin = current_user.bulletins.find_or_initialize_by(
      title: Faker::Lorem.word,
      description: Faker::Lorem.paragraph(sentence_count: 2),
      category: Category.all.sample,
      state: Bulletin.aasm.states.map(&:name).sample
    )

    unless bulletin.persisted?
      bulletin.image.attach(io: File.open(Rails.root.join('test/fixtures/files/image.jpg')), filename: 'image.jpg')
      bulletin.save
    end
  end
end
