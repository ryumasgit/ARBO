# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#　管理者初期データ
  Admin.create!(
  name: 'admin',
  email: 'admin@login',
  password: '111111'
  )

  #　ゲストメンバー初期データ
  guest = Member.create!(
  name: 'guest',
  email: 'guest@example.com',
  is_active: 'true',
  is_guest: 'true',
  password: '111111'
  )

  #　メンバー初期データ
  guest.member_image.attach(io: File.open(Rails.root.join('app/assets/images/members/GeorgiaO’Keeffe.jpg')), filename: 'GeorgiaO’Keeffe.jpg')

  member1 =  Member.create!(
  name: 'John Doe',
  email: 'john@example.com',
  is_active: 'true',
  is_guest: 'false',
  password: '111111'
  )

  member1.member_image.attach(io: File.open(Rails.root.join('app/assets/images/members/ClaudeMonet.jpg')), filename: 'ClaudeMonet.jpg')

  member2 = Member.create!(
  name: 'Robert Johnson',
  email: 'robert@example.com',
  is_active: 'false',
  is_guest: 'false',
  password: '111111'
  )

  member2.member_image.attach(io: File.open(Rails.root.join('app/assets/images/members/StanleyTigerman.png')), filename: 'StanleyTigerman.png')

  member3 = Member.create!(
  name: 'Mike',
  email: 'mike@com',
  is_active: 'true',
  is_guest: 'false',
  password: '111111'
  )

  member3.member_image.attach(io: File.open(Rails.root.join('app/assets/images/members/AlmaThomas.jpg')), filename: 'AlmaThomas.jpg')

  museum1 = Museum.create!(
  name: 'エデン・アートギャラリー',
  introduction: 'エデン・アートギャラリーは、芸術と創造性の楽園です。世界中から集められた美術品が、ここで新しい命を吹き込まれ、あなたの心に触れるでしょう。
  絵画、彫刻、写真、インスタレーションアートなど、あらゆるジャンルの作品が展示され、訪れる人々に魔法のような体験を提供します。
  我々の使命は、芸術を通じて人々をつなぎ、魅了し、啓発することです。エデン・アートギャラリーで、新しい視点を見つけましょう。',
  official_website: 'https://web-camp.io/commit/',
  is_active: 'true',
  )

  #　美術館初期データ
  museum1.museum_images.attach(io: File.open(Rails.root.join('app/assets/images/museums/museum_image1.jpeg')), filename: 'museum_image1.jpeg')

  museum2 = Museum.create!(
  name: 'セレスティアル・アートインスティチュート',
  introduction: 'セレスティアル・アートインスティチュートは、天空の彼方から灵感を受けた美術の聖域です。ここでは、宇宙とアートが融合し、驚異的な作品が生み出されています。
  星座のようなアート作品、銀河を旅するようなインスタレーション、宇宙の謎に触れる美術品が展示されています。
  セレスティアル・アートインスティチュートを訪れて、宇宙の美しさと無限の可能性に触れ、魅了されることでしょう。我々の使命は、芸術を通じて宇宙への旅を提供することです。',
  official_website: 'https://web-camp.io/commit/',
  is_active: 'true',
  )

  museum2.museum_images.attach(io: File.open(Rails.root.join('app/assets/images/museums/museum_image2.jpeg')), filename: 'museum_image2.jpeg')

  exhibition1 = Exhibition.create!(
  museum_id: 1,
  name: '未来の色彩：創造性の旅',
  introduction: '未来の色彩：創造性の旅」展示会は、色彩と想像力の饗宴です。この展示会では、未来の美しい世界を描くためのアーティストたちが、鮮やかな色彩と独自の視点を結集しました。
  絵画、彫刻、デジタルアート、立体作品など、さまざまなメディアを駆使して、未知の風景を探求します。我々は未来を夢見、色彩でその可能性を表現します。この展示会で、創造性の旅に出発しましょう。',
  official_website: 'https://web-camp.io/commit/',
  is_active: 'true',
  )

  #　展示会初期データ
  exhibition1.exhibition_images.attach(io: File.open(Rails.root.join('app/assets/images/exhibitions/exhibition_image1.jpg')), filename: 'exhibition_image1.jpg')

  exhibition2 = Exhibition.create!(
  museum_id: 2,
  name: '幻想の境界：アートの魔法',
  introduction: '「幻想の境界：アートの魔法」展示会は、現実と夢の間の不思議な旅へと招待します。この展示会では、アーティストたちがその想像力を解き放ち、アートの魅力的な魔法を生み出しています。
  ファンタジーの世界、魔法の生き物、神秘的な風景、そして夢の中の物語が、絵画、彫刻、フォトマニピュレーション、立体作品として具現化されます。我々はアートを通じて新たな世界を創造し、幻想の境界に足を踏み入れます。
  この展示会で、アートの魔法を体験しましょう。',
  official_website: 'https://web-camp.io/commit/',
  is_active: 'true',
  )

  exhibition2.exhibition_images.attach(io: File.open(Rails.root.join('app/assets/images/exhibitions/exhibition_image2.jpg')), filename: 'exhibition_image2.jpg')

  claude_monet = Artist.create!(
  name: 'クロード・モネ',
  introduction: '印象派の巨匠。自然光と色彩に魅了され、美しい睡蓮や風景を描く画家。印象、日の出、睡蓮の名作。',
  is_active: 'true',
  )

  #　アーティスト初期データ
  claude_monet.artist_images.attach(io: File.open(Rails.root.join('app/assets/images/artists/Stacks of Wheat (End of Summer).jpg')), filename: 'Stacks of Wheat (End of Summer).jpg')

  edouard_manet = Artist.create!(
  name: 'エドゥアール・マネ',
  introduction: '印象派の先駆者。都市の魅力と社会を捉え、モダンな都会生活を描く画家。',
  is_active: 'true',
  )

  edouard_manet.artist_images.attach(io: File.open(Rails.root.join('app/assets/images/artists/Woman Reading.jpg')), filename: 'Woman Reading.jpg')

  pierre_auguste_renoir = Artist.create!(
  name: 'ピエール＝オーギュスト・ルノワール',
  introduction: '明るく活気あふれる印象派の一員。人々や風景、ダンスを美しく描く。',
  is_active: 'true',
  )

  pierre_auguste_renoir.artist_images.attach(io: File.open(Rails.root.join('app/assets/images/artists/Two Sisters (On the Terrace).jpg')), filename: 'Two Sisters (On the Terrace).jpg')

  camille_pissarro = Artist.create!(
  name: 'カミーユ・ピサロ',
  introduction: '印象派の創始者の一人。農村風景や都市を通じて風景画に情熱を注ぐ。',
  is_active: 'true',
  )

  camille_pissarro.artist_images.attach(io: File.open(Rails.root.join('app/assets/images/artists/Young Peasant Having Her Coffee.jpg')), filename: 'Young Peasant Having Her Coffee.jpg')


  #　バッジ初期データ
  first_post = Badge.create!(
  name: 'First Post',
  introduction: '',
  is_active: 'true',
  )

  first_post.badge_image.attach(io: File.open(Rails.root.join('app/assets/images/badges/first_post.png')), filename: 'first_post.png')

  first_comment = Badge.create!(
  name: 'First Post',
  introduction: '',
  is_active: 'true',
  )

  first_comment.badge_image.attach(io: File.open(Rails.root.join('app/assets/images/first_comment.png')), filename: 'first_comment.png')

  first_follower = Badge.create!(
  name: 'First Follower',
  introduction: '',
  is_active: 'true',
  )

  first_follower.badge_image.attach(io: File.open(Rails.root.join('app/assets/images/first_follower.png')), filename: 'first_follower.png')

  first_favorited = Badge.create!(
  name: 'First Favorited',
  introduction: '',
  is_active: 'true',
  )

  first_favorited.badge_image.attach(io: File.open(Rails.root.join('app/assets/images/badges/first_favorited.png')), filename: 'first_favorited.png')

  museum_enthusiast = Badge.create!(
  name: 'Museum Enthusiast',
  introduction: '',
  is_active: 'true',
  )

  museum_enthusiast.badge_image.attach(io: File.open(Rails.root.join('app/assets/images/museum_enthusiast.png')), filename: 'museum_enthusiast.png')

  exhibition_enthusiast = Badge.create!(
  name: 'Exhibition Enthusiast',
  introduction: '',
  is_active: 'true',
  )

  exhibition_enthusiast.badge_image.attach(io: File.open(Rails.root.join('app/assets/images/badges/exhibition_enthusiast.png')), filename: 'exhibition_enthusiast.png')