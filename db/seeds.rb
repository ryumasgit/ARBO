# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  # adminモデル初期データ
  Admin.create!(
  name: 'admin',
  email: 'admin@login',
  password: '111111'
  )

  # memberモデル(guest)初期データ
  guest = Member.create!(
  name: 'guest',
  introduction: "ようこそ、ゲストメンバーのプロフィールへ！私はこのコミュニティへの新しい訪問者です。美術と文化に興味があり、さまざまなアーティストの作品を楽しんでいます。どうぞお気軽にコミュニティに参加してください。",
  email: 'guest@example.com',
  is_active: true,
  is_guest: true,
  password: '111111'
  )
  guest.member_image.attach(io: File.open(Rails.root.join('app/assets/images/members/GeorgiaO’Keeffe.jpg')), filename: 'GeorgiaO’Keeffe.jpg')

  # memberモデル初期データ
  member1 =  Member.create!(
  name: 'John Doe',
  introduction: "こんにちは、私はJohn Doeです。美術愛好者で、特に印象派の作品が大好きです。美術館やギャラリーで新しい芸術体験を探すことが趣味です。アートについて語り合いましょう！",
  email: 'john@example.com',
  is_active: true,
  is_guest: false,
  password: '111111'
  )
  member1.member_image.attach(io: File.open(Rails.root.join('app/assets/images/members/ClaudeMonet.jpg')), filename: 'ClaudeMonet.jpg')

  member2 = Member.create!(
  name: 'Robert Johnson',
  introduction: "私の名前はRobert Johnsonです。建築家で、美術館や建築デザインに興味を持っています。美術館の建築や展示会の空間デザインについて議論したり、アイデアを共有したりできる仲間を探しています。",
  email: 'robert@example.com',
  is_active: true,
  is_guest: false,
  password: '111111'
  )
  member2.member_image.attach(io: File.open(Rails.root.join('app/assets/images/members/StanleyTigerman.png')), filename: 'StanleyTigerman.png')

  member3 = Member.create!(
  name: 'Mike',
  introduction: "こんにちは、私はMikeです。アートと音楽が大好きなエンターテイメント愛好者です。美術館での音楽イベントやアートフェスティバルに参加するのが楽しみです。アートと音楽の世界に一緒に浸りましょう！",
  email: 'mike@com',
  is_active: true,
  is_guest: false,
  password: '111111'
  )
  member3.member_image.attach(io: File.open(Rails.root.join('app/assets/images/members/AlmaThomas.jpg')), filename: 'AlmaThomas.jpg')


  # museumモデル初期データ
  museum1 = Museum.create!(
    name: 'エデン・アートギャラリー',
    introduction: 'エデン・アートギャラリーは、芸術と創造性の楽園です。世界中から集められた美術品が、ここで新しい命を吹き込まれ、あなたの心に触れるでしょう。絵画、彫刻、写真、インスタレーションアートなど、あらゆるジャンルの作品が展示され、訪れる人々に魔法のような体験を提供します。我々の使命は、芸術を通じて人々をつなぎ、魅了し、啓発することです。エデン・アートギャラリーで、新しい視点を見つけましょう。',
    official_website: 'https://web-camp.io/commit/',
    is_active: true
  )
  museum1.museum_images.attach(io: File.open(Rails.root.join('app/assets/images/museums/museum_image1.jpg')), filename: 'museum_image1.jpg')

  museum2 = Museum.create!(
    name: 'セレスティアル・アートインスティチュート',
    introduction: 'セレスティアル・アートインスティチュートは、天空の彼方から灵感を受けた美術の聖域です。ここでは、宇宙とアートが融合し、驚異的な作品が生み出されています。星座のようなアート作品、銀河を旅するようなインスタレーション、宇宙の謎に触れる美術品が展示されています。セレスティアル・アートインスティチュートを訪れて、宇宙の美しさと無限の可能性に触れ、魅了されることでしょう。我々の使命は、芸術を通じて宇宙への旅を提供することです。',
    official_website: 'https://web-camp.io/commit/',
    is_active: true
  )
  museum2.museum_images.attach(io: File.open(Rails.root.join('app/assets/images/museums/museum_image2.jpg')), filename: 'museum_image2.jpg')

  museum3 = Museum.create!(
    name: 'クリスタル・アートギャラリー',
    introduction: 'クリスタル・アートギャラリーは、鉱物や宝石、結晶などの自然の美しさを称える美術館です。美しい鉱石や結晶が、アーティストたちによって芸術的な作品に昇華されています。訪れる人々は、地球の奇跡的な美しさに感銘を受け、宝石や鉱石の不思議な世界を探求できます。',
    official_website: 'https://web-camp.io/commit/',
    is_active: true
  )
  museum3.museum_images.attach(io: File.open(Rails.root.join('app/assets/images/museums/museum_image3.jpg')), filename: 'museum_image3.jpg')

  museum4 = Museum.create!(
    name: '未来のデジタル・アートセンター',
    introduction: '未来のデジタル・アートセンターは、最新のテクノロジーを駆使して創られたデジタルアート作品を展示する施設です。ここでは、バーチャルリアリティ（VR）や拡張現実（AR）などを活用した、没入型の芸術体験が提供されます。訪れる人々は、未来のアートとテクノロジーの融合に圧倒されることでしょう。',
    official_website: 'https://web-camp.io/commit/',
    is_active: true
  )
  museum4.museum_images.attach(io: File.open(Rails.root.join('app/assets/images/museums/museum_image4.jpg')), filename: 'museum_image4.jpg')

  museum5 = Museum.create!(
    name: 'アンダーシー・アートギャラリー',
    introduction: 'アンダーシー・アートギャラリーは、海洋と水中世界をテーマにした美術館です。ここでは、水中写真、海洋生物の彫刻、珊瑚の芸術、そして深海の謎に触れる作品が展示されています。訪れる人々は、海の神秘的な美しさに魅了され、自然の豊かさに感謝の気持ちを抱くことでしょう。',
    official_website: 'https://web-camp.io/commit/',
    is_active: true
  )
  museum5.museum_images.attach(io: File.open(Rails.root.join('app/assets/images/museums/museum_image5.jpg')), filename: 'museum_image5.jpg')

  museum6 = Museum.create!(
    name: 'インプレッション・アートギャラリー',
    introduction: 'インプレッション・アートギャラリーは、印象派芸術の魔法の世界への招待状です。ここでは、19世紀末のフランスで生まれた印象派運動の美しさと革命的な影響が融合します。モネ、ルノワール、セザンヌ、ドガ、そして他の多くの印象派の巨匠たちの作品が、自然の中での瞬間の捉え方と鮮やかな色彩で展示されています。',
    official_website: 'https://web-camp.io/commit/',
    is_active: true
  )
  museum6.museum_images.attach(io: File.open(Rails.root.join('app/assets/images/museums/museum_image6.jpg')), filename: 'museum_image6.jpg')


  # exhibitionモデル初期データ
  exhibition1 = Exhibition.create!(
  museum_id: 1,
  name: '未来の色彩：創造性の旅',
  introduction: '未来の色彩：創造性の旅」展示会は、色彩と想像力の饗宴です。この展示会では、未来の美しい世界を描くためのアーティストたちが、鮮やかな色彩と独自の視点を結集しました。
  絵画、彫刻、デジタルアート、立体作品など、さまざまなメディアを駆使して、未知の風景を探求します。我々は未来を夢見、色彩でその可能性を表現します。この展示会で、創造性の旅に出発しましょう。',
  official_website: 'https://web-camp.io/commit/',
  is_active: true
  )
  exhibition1.exhibition_images.attach(io: File.open(Rails.root.join('app/assets/images/exhibitions/exhibition_image1.jpg')), filename: 'exhibition_image1.jpg')

  exhibition2 = Exhibition.create!(
  museum_id: 2,
  name: '幻想の境界：アートの魔法',
  introduction: '「幻想の境界：アートの魔法」展示会は、現実と夢の間の不思議な旅へと招待します。この展示会では、アーティストたちがその想像力を解き放ち、アートの魅力的な魔法を生み出しています。
  ファンタジーの世界、魔法の生き物、神秘的な風景、そして夢の中の物語が、絵画、彫刻、フォトマニピュレーション、立体作品として具現化されます。我々はアートを通じて新たな世界を創造し、幻想の境界に足を踏み入れます。
  この展示会で、アートの魔法を体験しましょう。',
  official_website: 'https://web-camp.io/commit/',
  is_active: true
  )
  exhibition2.exhibition_images.attach(io: File.open(Rails.root.join('app/assets/images/exhibitions/exhibition_image2.jpg')), filename: 'exhibition_image2.jpg')

  exhibition3 = Exhibition.create!(
  museum_id: 3,
  name: '未来のアートフェスティバル',
  introduction: '未来のアートフェスティバルは、最新のテクノロジーと芸術の融合をテーマにした展示会です。
  ここでは、バーチャルリアリティ（VR）アート、人工知能（AI）によるアート、ロボットアートど、未来のアートの可能性を探求します。
  アーティストたちが創り出す驚くべき未来のビジョンを体験できます。',
  official_website: 'https://web-camp.io/commit/',
  is_active: true
  )
  exhibition3.exhibition_images.attach(io: File.open(Rails.root.join('app/assets/images/exhibitions/exhibition_image3.jpg')), filename: 'exhibition_image3.jpg')

  exhibition4 = Exhibition.create!(
  museum_id: 4,
  name: 'クラシカル・マスターピーシズ展',
  introduction: 'クラシカル・マスターピーシズ展は、歴史的な美術の傑作を称える展示会です。
  ここでは、ルネサンス期からバロック期までの名画や彫刻が一堂に展示され、訪れる人々にクラシックな芸術の美しさを提供します。
  美術史の中で輝く作品たちを堪能できます。',
  official_website: 'https://web-camp.io/commit/',
  is_active: true
  )
  exhibition4.exhibition_images.attach(io: File.open(Rails.root.join('app/assets/images/exhibitions/exhibition_image4.jpg')), filename: 'exhibition_image4.jpg')

  exhibition5 = Exhibition.create!(
  museum_id: 5,
  name: '自然との対話: 環境アートショウ',
  introduction: '自然との対話: 環境アートショウは、自然との調和をテーマにした展示会です。
  アーティストたちは自然の素材を使用し、風景アート、リサイクルアート、植物アートなどを制作します。
  訪れる人々は、環境への深い愛情を感じながら、美しい作品に触れることができます。',
  official_website: 'https://web-camp.io/commit/',
  is_active: true
  )
  exhibition5.exhibition_images.attach(io: File.open(Rails.root.join('app/assets/images/exhibitions/exhibition_image5.jpg')), filename: 'exhibition_image5.jpg')

  exhibition6 = Exhibition.create!(
  museum_id: 1,
  name: '未知の世界: 宇宙アートエキスポ',
  introduction: '未知の世界: 宇宙アートエキスポは、宇宙と宇宙探査をテーマにした展示会です。
  ここでは、宇宙写真、宇宙船デザイン、宇宙ステーション模型など、宇宙への情熱を表現したアートが展示されます。
  宇宙の神秘的な美しさに魅了されることでしょう。',
  official_website: 'https://web-camp.io/commit/',
  is_active: true
  )
  exhibition6.exhibition_images.attach(io: File.open(Rails.root.join('app/assets/images/exhibitions/exhibition_image6.jpg')), filename: 'exhibition_image6.jpg')

  exhibition7 = Exhibition.create!(
  museum_id: 2,
  name: '感覚の迷宮: インタラクティブアートショー',
  introduction: '感覚の迷宮: インタラクティブアートショーは、訪れる人々がアート作品と対話し、体験することを奨励する展示会です。
  触れたり、音楽を奏でたり、アート作品を操作することで、感覚的な冒険が展開されます。アート作品との一体感を楽しんでください。',
  official_website: 'https://web-camp.io/commit/',
  is_active: true
  )
  exhibition7.exhibition_images.attach(io: File.open(Rails.root.join('app/assets/images/exhibitions/exhibition_image7.jpg')), filename: 'exhibition_image7.jpg')

  exhibition8 = Exhibition.create!(
  museum_id: 3,
  name: 'ワールド・カルチャーズ・フェスティバル',
  introduction: 'ワールド・カルチャーズ・フェスティバルは、世界中の多様な文化と芸術を称える展示会です。
  ここでは、異なる国々の伝統的な衣装、音楽、絵画、工芸品などが展示され、文化の豊かさが紹介されます。多彩な文化に触れ、国際的なアートとつながりましょう。',
  official_website: 'https://web-camp.io/commit/',
  is_active: true
  )
  exhibition8.exhibition_images.attach(io: File.open(Rails.root.join('app/assets/images/exhibitions/exhibition_image8.jpg')), filename: 'exhibition_image8.jpg')


  # artistモデル初期データ
  claude_monet = Artist.create!(
  name: 'クロード・モネ',
  introduction: '印象派の巨匠。自然光と色彩に魅了され、美しい睡蓮や風景を描く画家。印象、日の出、睡蓮の名作。',
  is_active: true
  )
  claude_monet.artist_images.attach(io: File.open(Rails.root.join('app/assets/images/artists/Stacks of Wheat (End of Summer).jpg')), filename: 'Stacks of Wheat (End of Summer).jpg')

  edouard_manet = Artist.create!(
  name: 'エドゥアール・マネ',
  introduction: '印象派の先駆者。都市の魅力と社会を捉え、モダンな都会生活を描く画家。',
  is_active: true
  )
  edouard_manet.artist_images.attach(io: File.open(Rails.root.join('app/assets/images/artists/Woman Reading.jpg')), filename: 'Woman Reading.jpg')

  pierre_auguste_renoir = Artist.create!(
  name: 'ピエール＝オーギュスト・ルノワール',
  introduction: '明るく活気あふれる印象派の一員。人々や風景、ダンスを美しく描く。',
  is_active: true
  )
  pierre_auguste_renoir.artist_images.attach(io: File.open(Rails.root.join('app/assets/images/artists/Two Sisters (On the Terrace).jpg')), filename: 'Two Sisters (On the Terrace).jpg')

  camille_pissarro = Artist.create!(
  name: 'カミーユ・ピサロ',
  introduction: '印象派の創始者の一人。農村風景や都市を通じて風景画に情熱を注ぐ。',
  is_active: true
  )
  camille_pissarro.artist_images.attach(io: File.open(Rails.root.join('app/assets/images/artists/Young Peasant Having Her Coffee.jpg')), filename: 'Young Peasant Having Her Coffee.jpg')

  leonardo_da_vinci = Artist.create!(
  name: 'レオナルド・ダ・ヴィンチ',
  introduction: 'イタリアの万能な天才で、モナリザや最後の晩餐などの代表作で知られています。彼はルネサンス期の芸術家で、科学、工学、解剖学にも貢献しました。',
  is_active: true
  )
  leonardo_da_vinci.artist_images.attach(io: File.open(Rails.root.join("app/assets/images/artists/Madonna and Child (recto) and Fragment of Woman's Torso (verso).jpg")), filename: "Madonna and Child (recto) and Fragment of Woman's Torso (verso).jpg")

  pablo_picasso = Artist.create!(
  name: 'ピカソ',
  introduction: 'スペイン出身の近代美術の巨匠で、キュビズムや抽象表現主義のパイオニアです。代表作に『ゲルニカ』があります。',
  is_active: true
  )
  pablo_picasso.artist_images.attach(
    [
      { io: File.open(Rails.root.join('app/assets/images/artists/The Red Armchair.jpg')), filename: 'The Red Armchair.jpg' },
      { io: File.open(Rails.root.join('app/assets/images/artists/The Old Guitarist.jpg')), filename: 'The Old Guitarist.jpg' },
      { io: File.open(Rails.root.join('app/assets/images/artists/Mother and Child.jpg')), filename: 'Mother and Child.jpg' },
      { io: File.open(Rails.root.join('app/assets/images/artists/Daniel-Henry Kahnweiler.jpg')), filename: 'Daniel-Henry Kahnweiler.jpg' }
    ]
  )

  vincent_van_gogh = Artist.create!(
  name: 'ヴィンセント・ファン・ゴッホ',
  introduction: 'オランダの後期印象派の画家で、鮮やかな色彩と感情豊かな筆致が特徴です。代表作に『星月夜』や『ひまわり』があります。',
  is_active: true
  )
  vincent_van_gogh.artist_images.attach(
    [
      { io: File.open(Rails.root.join('app/assets/images/artists/The Bedroom.jpg')), filename: 'The Bedroom.jpg' },
      { io: File.open(Rails.root.join('app/assets/images/artists/Self-Portrait.jpg')), filename: 'Self-Portrait.jpg' },
      { io: File.open(Rails.root.join('app/assets/images/artists/Fishing in Spring the Pont de Clichy.jpg')), filename: 'Fishing in Spring the Pont de Clichy.jpg' }
    ]
  )

  jackson_pollock = Artist.create!(
  name: 'ジャクソン・ポロック',
  introduction: 'アメリカの抽象表現主義の代表的な画家で、ドリップ・ペインティングと呼ばれるスタイルで知られています。代表作に『ナンバー 1A, 1948』があります。',
  is_active: true
  )
  jackson_pollock.artist_images.attach(
    [
      { io: File.open(Rails.root.join('app/assets/images/artists/The Key.jpg')), filename: 'The Key.jpg' },
      { io: File.open(Rails.root.join('app/assets/images/artists/Untitled.jpg')), filename: 'Untitled.jpg' }
    ]
  )

  # entry_artistモデル初期データ
  EntryArtist.create!(
  exhibition_id: 1,
  artist_id: 1
  )

  EntryArtist.create!(
  exhibition_id: 1,
  artist_id: 2
  )

  EntryArtist.create!(
  exhibition_id: 1,
  artist_id: 3
  )

  EntryArtist.create!(
  exhibition_id: 1,
  artist_id: 4
  )

  EntryArtist.create!(
  exhibition_id: 1,
  artist_id: 5
  )

  EntryArtist.create!(
  exhibition_id: 1,
  artist_id: 6
  )

  EntryArtist.create!(
  exhibition_id: 2,
  artist_id: 5
  )

  EntryArtist.create!(
  exhibition_id: 2,
  artist_id: 3
  )

  EntryArtist.create!(
  exhibition_id: 2,
  artist_id: 8
  )

  EntryArtist.create!(
  exhibition_id: 3,
  artist_id: 1
  )

  EntryArtist.create!(
  exhibition_id: 3,
  artist_id: 2
  )

  EntryArtist.create!(
  exhibition_id: 3,
  artist_id: 8
  )

  EntryArtist.create!(
  exhibition_id: 4,
  artist_id: 7
  )

  EntryArtist.create!(
  exhibition_id: 4,
  artist_id: 6
  )

  EntryArtist.create!(
  exhibition_id: 5,
  artist_id: 4
  )

  EntryArtist.create!(
  exhibition_id: 5,
  artist_id: 1
  )

  EntryArtist.create!(
  exhibition_id: 6,
  artist_id: 1
  )

  EntryArtist.create!(
  exhibition_id: 6,
  artist_id: 2
  )

  EntryArtist.create!(
  exhibition_id: 6,
  artist_id: 7
  )

  EntryArtist.create!(
  exhibition_id: 7,
  artist_id: 8
  )

  EntryArtist.create!(
  exhibition_id: 7,
  artist_id: 6
  )

  EntryArtist.create!(
  exhibition_id: 7,
  artist_id: 7
  )

  EntryArtist.create!(
  exhibition_id: 8,
  artist_id: 4
  )

  EntryArtist.create!(
  exhibition_id: 8,
  artist_id: 2
  )

  EntryArtist.create!(
  exhibition_id: 8,
  artist_id: 5
  )

  # badgeモデル初期データ
  first_post = Badge.create!(
  name: 'First Post',
  introduction: 'このバッジは、初めて投稿したメンバーに授与されます。アイデアや情報を共有してコミュニティに貢献しましょう。',
  is_active: true
  )
  first_post.badge_image.attach(io: File.open(Rails.root.join('app/assets/images/badges/first_post.png')), filename: 'first_post.png')

  first_comment = Badge.create!(
  name: 'First Comment',
  introduction: ' このバッジは、他のメンバーの投稿に初めてコメントしたメンバーに授与されます。他のメンバーとの対話を楽しんで、意見を交換しましょう。',
  is_active: true
  )
  first_comment.badge_image.attach(io: File.open(Rails.root.join('app/assets/images/badges/first_comment.png')), filename: 'first_comment.png')

  first_follower = Badge.create!(
  name: 'First Follower',
  introduction: 'このバッジは���他のメンバーから初めてフォローされたメンバーに授与されます。コンテンツが注目されていることを示します。',
  is_active: true
  )
  first_follower.badge_image.attach(io: File.open(Rails.root.join('app/assets/images/badges/first_follower.png')), filename: 'first_follower.png')

  first_favorited = Badge.create!(
  name: 'First Favorited',
  introduction: 'このバッジは、他のメンバーから初めてお気に入りに登録されたメンバーに授与されます。あなたのコンテンツが人々に愛されています。',
  is_active: true
  )
  first_favorited.badge_image.attach(io: File.open(Rails.root.join('app/assets/images/badges/first_favorited.png')), filename: 'first_favorited.png')

  museum_enthusiast = Badge.create!(
  name: 'Museum Enthusiast',
  introduction: 'このバッジは、美術館に多く足を運んだメンバーに授与されます。これからも美術館の魅力を伝え、共有しましょう。',
  is_active: true
  )
  museum_enthusiast.badge_image.attach(io: File.open(Rails.root.join('app/assets/images/badges/museum_enthusiast.png')), filename: 'museum_enthusiast.png')

  exhibition_enthusiast = Badge.create!(
  name: 'Exhibition Enthusiast',
  introduction: 'このバッジは、展示会に多く足を運んだメンバーに授与されます。これからも展示会の魅力を伝え、共有しましょう。',
  is_active: true
  )
  exhibition_enthusiast.badge_image.attach(io: File.open(Rails.root.join('app/assets/images/badges/exhibition_enthusiast.png')), filename: 'exhibition_enthusiast.png')


  # reviewモデル初期データ
  review1 = Review.create!(
  member_id: 2,
  exhibition_id: 1,
  body: 'この展示会は美しい色彩と芸術の調和を楽しむ素晴らしい機会でした。特に『未来の色彩』という作品には驚きました。'
  )
  review1.review_image.attach(io: File.open(Rails.root.join('app/assets/images/reviews/A Sunday on La Grande Jatte — 1884.jpg')), filename: 'A Sunday on La Grande Jatte — 1884.jpg')

  review2 = Review.create!(
  member_id: 3,
  exhibition_id: 2,
  body: '美術館の展示会は、現代アートの真髄を捉えたもので、芸術家の創造力に感銘を受けました。'
  )
  review2.review_image.attach(io: File.open(Rails.root.join('app/assets/images/reviews/Arrival of the Normandy Train, Gare Saint-Lazare.jpg')), filename: 'Arrival of the Normandy Train, Gare Saint-Lazare.jpg')

  review3 = Review.create!(
  member_id: 4,
  exhibition_id: 3,
  body: '印象派の名作が多数展示されており、風景画や人物画に魅了されました。特に、クロード・モネの作品は素晴らしかった。'
  )
  review3.review_image.attach(io: File.open(Rails.root.join('app/assets/images/reviews/Ballet at the Paris Opera.jpg')), filename: 'Ballet at the Paris Opera.jpg')

  review4 = Review.create!(
  member_id: 2,
  exhibition_id: 4,
  body: '現代アートの展示会は斬新で興味深いもので、芸術の新しい方向性に触れることができました。'
  )
  review4.review_image.attach(io: File.open(Rails.root.join('app/assets/images/reviews/Coronation Stone of Motecuhzoma II (Stone of the....jpg')), filename: 'Coronation Stone of Motecuhzoma II (Stone of the....jpg')

  review5 = Review.create!(
  member_id: 3,
  exhibition_id: 5,
  body: '美術館の展示会は私にとって驚きの体験でした。異なるスタイルや時代の作品が共存し、多様性に触れました。'
  )
  review5.review_image.attach(io: File.open(Rails.root.join('app/assets/images/reviews/The Assumption of the Virgin.jpg')), filename: 'The Assumption of the Virgin.jpg')

  review6 = Review.create!(
  member_id: 4,
  exhibition_id: 8,
  body: '美術館の展示会は美的な体験で、芸術家の創造力に敬意を表します。'
  )
  review6.review_image.attach(io: File.open(Rails.root.join('app/assets/images/reviews/The Beach at Sainte-Adresse.jpg')), filename: 'The Beach at Sainte-Adresse.jpg')

  review7 = Review.create!(
  member_id: 2,
  exhibition_id: 7,
  body: 'この展示会は美しい色彩と芸術の調和を楽しむ素晴らしい機会でした。特に『未来の色彩』という作品には驚きました。'
  )
  review7.review_image.attach(io: File.open(Rails.root.join("app/assets/images/reviews/The Child's Bath.jpg")), filename: "The Child's Bath.jpg")

  review8 = Review.create!(
  member_id: 3,
  exhibition_id: 8,
  body: 'この展示会は美しい色彩と芸術の調和を楽しむ素晴らしい機会でした。特に『未来の色彩』という作品には驚きました。'
  )
  review8.review_image.attach(io: File.open(Rails.root.join('app/assets/images/reviews/The Herring Net.jpg')), filename: 'The Herring Net.jpg')

  review9 = Review.create!(
  member_id: 4,
  exhibition_id: 6,
  body: 'この展示会は感情的な旅で、作品が魂に触れる瞬間でした。特に、ヴィンセント・ファン・ゴッホの作品に感動しました。'
  )
  review9.review_image.attach(io: File.open(Rails.root.join('app/assets/images/reviews/The Watermill with the Great Red Roof.jpg')), filename: 'The Watermill with the Great Red Roof.jpg')

  review10 = Review.create!(
  member_id: 2,
  exhibition_id: 1,
  body: '美術館の展示会には魅力的な作品が展示されており、芸術愛好家には必見の場所です。'
  )
  review10.review_image.attach(io: File.open(Rails.root.join('app/assets/images/reviews/Under the Wave off Kanagawa (Kanagawa oki nami....jpg')), filename: 'Under the Wave off Kanagawa (Kanagawa oki nami....jpg')

  review11 = Review.create!(
  member_id: 3,
  exhibition_id: 2,
  body: '美術館の展示会は美の探求の旅で、芸術作品が魔法のように魅了しました。心に残る体験でした。'
  )
  review11.review_image.attach(io: File.open(Rails.root.join('app/assets/images/reviews/Veranda Post.jpg')), filename: 'Veranda Post.jpg')

  review12 = Review.create!(
  member_id: 4,
  exhibition_id: 3,
  body: 'この展示会は歴史と対話する機会であり、過去から現在への美的な旅でした。展示作品は感動的でした。'
  )
  review12.review_image.attach(io: File.open(Rails.root.join('app/assets/images/reviews/Woman at Her Toilette.jpg')), filename: 'Woman at Her Toilette.jpg')