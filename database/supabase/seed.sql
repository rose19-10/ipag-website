-- =============================================
-- IPAG Website — Seed Data
-- Run this in the Supabase SQL Editor AFTER running schema.sql
-- Sources: ipagarts.com + productionData.js hardcoded content
-- =============================================


-- ─────────────────────────────────────────
-- DIRECTOR
-- ─────────────────────────────────────────
-- Only insert if no director record exists yet
do $$
begin
  if not exists (select 1 from director limit 1) then
    insert into director (
        name, title, photo,
        stat_productions, stat_books, stat_years,
        bio_col1, bio_col2,
        quote,
        distinctions
    ) values (
    'Steven P.C. Fernandez',
    'DFA · Playwright · Composer · Scholar',
    '/images/TFM2.jpg',
    '50+', '6', '47',
    'Multi-awarded dramaturge, director-playwright, music composer-arranger, and scholar, Steven P.C. Fernandez founded the Integrated Performing Arts Guild in 1978 and has led it through nearly five decades of original Philippine performance. He has produced over fifty productions drawing acclamation across the world and the Philippines — works that span four decades, anthologized, published, and widely acknowledged.

His established methods in performance mark innovative processes in production now recognized in Philippine dramaturgy, essayed in six books and numerous papers published in national and international journals. Transcreation and Distillation — performance principles he developed — are widely acknowledged in dance and performance pedagogy worldwide.

My dramaturgy has always been non-conventional. I have explored ways to perform beyond the usual — merging genres, tearing down the fourth wall, arranging scenes in non-balanced spaces, narrating in arbitrary time rather than in chronology, traversing the objective to the magical mythic world, employing devised improvisations, composing in non-harmonic tones, and deconstructing the play skeleton.',
    'As Visiting Professor and Culture-Performance Studies specialist, he has lectured in Sharjah, Shanghai, Bangkok, Singapore, Ho Chi Minh, Yogyakarta, and Taipei. He has been awarded Fellowships to Sweden, Japan, and the United States, where he trained in Theatre Anthropology under Eugenio Barba.

His Ramayana drew international acclaim in Mumbai, New Delhi, Kolkata, Bangkok, and Singapore. IPAG under his direction has performed to thousands in over a hundred festivals and cities worldwide, receiving the CCP''s highest distinction for a performing company — the Gawad para sa Sining — in 2020.

Epics are living and lived narratives. These tell the stories of the "now," of how heroes save their own people, of how one community copes with surviving in conflict with another. Epics are our stories. They chronicle with feel and sense the vicissitudes we all go through.',
    'The traditional is the contemporary — and inspired live performance continues to speak to the world.',
    '["CCP Gawad para sa Sining (2020)","CCP Gador Award — 1st Recipient (2022)","ITI Lampara para sa Kultura at Sining (2025)","ASPROFIL Spain — Creative and Cultural Excellence (2025)","NCCA SUDI Music Award (2025)","World Culture Festival 2025 — Humanitarian Award for Music and Fine Arts","UMPIL Pambansang Alagad ni Balagtas (2014)","UMPIL Gawad Pedro Bucaneg (2015)","CCP Pilak (2004)","Fr. Francisco Demetrio Award for Culture and the Arts, Xavier University (2011)","SM Global Pinoy Award (2010)","Palanca Award — 1st Place, MingMing (2006)","Palanca Award — 3rd Place, Badung (2022)","CCP Gantimpala Award","Who''s Who in the World, 2001 — Cambridge Biographical Centre","2000 Outstanding Intellectuals of the 21st Century — Cambridge Biographical Centre","Defender of Our Heritage — Fookien Times Philippine Yearbook, 2004","CCP Encyclopedia of the Arts — first and latest editions","Top Ten Outstanding Alumni, Dept. of English, Mindanao State University (2012)","Group Study Exchange Scholar, Rotary International, USA (1989)","Local Fellow for Drama, UP Creative Writing Center (1993–1994)","Japan Foundation Observation Trip for Young Theater Leaders (1999)","Outstanding Citizen Award for Culture and Arts, Iligan Sinulog Jaycee Senate (1993)"]'::jsonb
    );
  end if;
end $$;


-- ─────────────────────────────────────────
-- HISTORY EVENTS
-- ─────────────────────────────────────────
insert into history_events (year, title, description, sort_order) values
('1978', 'The Guild is Founded',          'Steven P.C. Fernandez and Ligaya Fernando-Amilbangsa establish IPAG in Iligan City with a founding ensemble of twelve artists — the original IPAG 12. The Guild''s single direction: to perform and arouse the creative instincts of a city immersed in industry and technology.', 1),
('1979', 'First Productions',             'IPAG stages its earliest works — Makina, Ang Hawla, Kastilyo ni Kardo, and Fad Jazz — marking the Guild''s first creative season. A hand- and shadow-puppet show and "Star is Born" also debut this year.', 2),
('1981', 'Sarimanok Premieres',           'IPAG''s debut road show to Silliman University introduces Sarimanok to critical acclaim. Composed in 1980 and inspired by Bach''s Jonathan Livingston Seagull, its premiere had been cancelled when the Iligan plaza was bombed claiming several lives. It becomes the Guild''s signature work for decades.', 3),
('1982', 'UP Diamond Jubilee',            'Sarimanok is featured in the University of the Philippines'' Diamond Jubilee celebrations.', 4),
('1985', 'Ranaw: Isang Alamat',           'IPAG premieres Ranaw: Isang Alamat, which chains the Guild''s enduring engagement with the Cultural Center of the Philippines. It receives the CCP Playwriting Award.', 5),
('1986', 'Early Playwriting Honours',     'Patas wins the CCP Playwriting Workshop Outstanding Play award. Sarimanok is published by UP Likhaan. IPAG begins building its reputation as a playwright-driven company.', 6),
('1988', 'CCP Recognition',               'Sarimanok receives CCP Production and Touring Grants. IPAG wins the CCP National Drama Competition and begins building its national reputation.', 7),
('1989', 'CCP National Drama Competition','IPAG wins the CCP National Drama Competition — the first of many national distinctions. A Group Study Exchange Scholar fellowship to the USA follows for the Artistic Director.', 8),
('1991', 'Tales from Mindanao Created',   'Buhay, Pag-ibig, at Kamatayan: Mga Kwentong Mindanao (later retitled Tales From Mindanao, Tatlo sa Isa) is developed, drawing from Higaunon, M''ranao, Christian, and communal performance traditions of Mindanao.', 9),
('1992', 'Tales from Mindanao Premieres', 'Life, Love and Death: Tales From Mindanao premieres at the 1st CCP National Theatre Festival — immediately recognized as a landmark Philippine repertory production. Barangay Bara-Bara also premieres this year.', 10),
('1994', 'International Debut',           'Tales from Mindanao makes its international premiere at the Singapore Festival of the Arts, launching IPAG''s global touring career.', 11),
('1995', 'Datu Matu Premieres',           'Datu Matu premieres, depicting historical tensions during the American colonial period in Mindanao. The production earns international critical recognition.', 12),
('1996', 'European Tours',               'IPAG performs across France, Netherlands, Belgium, Spain, Portugal, and the United Kingdom in multiple international folkloric festivals, including the 5th Holten International Folkloric Festival and the Stockton Riverside International Festival.', 13),
('1998', 'Continued International Touring','IPAG performs in international festivals across France, Spain, and Portugal. Lawanen premieres.', 14),
('2000', 'How the Women of Joaquin Met Lawanen', 'New production premieres as IPAG continues expanding its repertoire.', 15),
('2002', 'Philippine National Day, Monaco','IPAG represents the Philippines at the Philippine National Day in Monte Carlo, Monaco. Tezcatlipoca is written.', 16),
('2004', 'Ming Ming Premieres',           'Ming Ming premieres. The Artistic Director is cited as "Defender of Our Heritage" in the 2004 Philippine Yearbook and is listed in Who''s Who in the World (Cambridge Biographical Centre).', 17),
('2006', 'UNESCO-ITI Festival & US Tour', 'Uwahig premieres at the UNESCO-ITI festival at the CCP. IPAG performs at the US Centennial Celebrations in Hawaii and the mainland. Ming Ming wins the Palanca Award First Place.', 18),
('2007', 'Taipei International Arts Festival','IPAG makes its international premiere at the Taipei Arts Festival with Uwahig.', 19),
('2009', 'SugaTula Premieres',            'SugaTula (originally Tula Tugma sa Sayaw at Dula) premieres. It later makes its international premiere in Taipei in 2012.', 20),
('2010', 'New Works and Asian Tours',     'IPAG premieres Suhi, Hapoy Daw Waig, and SITA: The Ramayana Revisited, beginning extensive touring across India, Thailand, Singapore, Taiwan, Vietnam, and Shanghai. The Artistic Director receives the SM Global Pinoy Award.', 21),
('2011', 'Fr. Demetrio Award',            'Steven P.C. Fernandez receives the Fr. Francisco Demetrio Award for Culture and the Arts from Xavier University. Hapoy Daw Wahig also premieres this year.', 22),
('2013', 'Sarimanok Remounted',           'Sarimanok is remounted — its third production — continuing the legacy of IPAG''s signature work.', 23),
('2014', 'UMPIL Pambansang Alagad ni Balagtas', 'Steven P.C. Fernandez receives the UMPIL Pambansang Alagad ni Balagtas, the highest distinction for a literary icon in the Philippines. Suhi makes its international premiere in Shanghai.', 24),
('2015', 'UMPIL Gawad Pedro Bucaneg',     'IPAG receives the UMPIL Gawad Pedro Bucaneg. SITA: The Ramayana Revisited premieres in the Philippines.', 25),
('2016', 'SITA Tours India & ASEAN',      'SITA tours India — Ayodhya, Mumbai, New Delhi, Kolkata — and represents the Philippines at the ASEAN Cultural Expo in Bangkok, Thailand.', 26),
('2017', 'India–ASEAN Summit',            'IPAG represents the Philippines at the India–ASEAN Summit in New Delhi and Kolkata. Orpheus Trilogy premieres with its international premiere at the Shanghai Theatre Academy.', 27),
('2018', 'Tribes For Peace & Gintong Alab','Tribes For Peace premieres with its international premiere on a US Tour. Gintong Alab ng Silangan also premieres.', 28),
('2019', 'Tighod Premieres',              'Tighod (Tides of Times) premieres, with its international premiere at the APB Festival in Hanoi. IPAG performs at the Mumbai Ramayana International Festival.', 29),
('2020', 'CCP Gawad para sa Sining',      'The CCP confers upon IPAG the Gawad para sa Sining — the highest distinction for a performing company in the Philippines. The CCP Gador is also awarded this year.', 30),
('2022', 'CCP Gador Award',               'IPAG and Steven P.C. Fernandez receive the 1st Gador Award from the CCP''s Kaisa sa Sining Program on July 7. Badung is submitted to the Palanca Awards, winning 3rd Place.', 31),
('2023', 'New Productions & ASEAN Panji', 'MarLen and the new Hapoy daw Waig (Fire and Water) premiere. IPAG represents the Philippines at the ASEAN Panji Festival in Indonesia.', 32),
('2024', 'IPAG Becomes Independent',      'After 46 seasons hosted by MSU-IIT, IPAG begins its 47th season as a fully independent performing company. IPAG performs for the 72nd Anniversary of Thailand Royalty. Panji (ASEAN Festival collaboration) also premieres.', 33),
('2025', 'World Culture Festival & New Honours', 'IPAG performs at the World Culture Festival in Karnataka, India, receiving the Humanitarian Award for Music and Fine Arts. The ITI Lampara para sa Kultura at Sining and ASPROFIL Spain Creative & Cultural Excellence awards are conferred. TESDA Region X accredits the IPAG Performing Arts Program. Isaulog, The Iligan Story premieres.', 34),
('2026', '49th Season Opens',             'IPAG officially launches its 49th Season on August 12, 2026, beginning the countdown toward its golden 50th anniversary in August 2027. New productions include Sinulog sa Iligan and the restaging of Ranaw: Isang Alamat.', 35)
on conflict do nothing;


-- ─────────────────────────────────────────
-- AWARDS & RECOGNITION
-- ─────────────────────────────────────────
insert into awards (year, title, detail, sort_order) values
('2025', 'World Culture Festival — Humanitarian Award for Music and Fine Arts',        'Karnataka, India', 1),
('2025', 'Lampara para sa Kultura at Sining',                                          'International Theatre Institute (ITI) with Philippine affiliate Earthsavers', 2),
('2025', 'Creative and Cultural Excellence',                                           'Asociacion Benefico Cultural Para la Promocion de Filipinas i España (ASPROFIL Spain)', 3),
('2025', 'NCCA SUDI Music Award',                                                      null, 4),
('2026', 'iLEAD Award',                                                                'Iligan City recognition for contributions to culture and the arts', 5),
('2022', 'CCP Gador Awards — 1st Recipient',                                           'Cultural Center of the Philippines, Kaisa sa Sining Program, July 7, 2022', 6),
('2020', 'CCP Gawad para sa Sining',                                                   'Highest distinction for a performing company, Cultural Center of the Philippines', 7),
('2020', 'CCP Gador',                                                                  'Cultural Center of the Philippines', 8),
('2015', 'UMPIL Gawad Pedro Bucaneg',                                                  null, 9),
('2014', 'UMPIL Pambansang Alagad ni Balagtas',                                        'Highest distinction for a literary icon in the Philippines — Steven P.C. Fernandez', 10),
('2011', 'Fr. Francisco Demetrio Award for Culture and the Arts',                      'Xavier University', 11),
('2010', 'SM Global Pinoy Award',                                                      'SM Superstores', 12),
('2006', '1st Place, Palanca Award — MingMing',                                        'One-Act Play, English category', 13),
('2022', '3rd Place, Palanca Award — Badung',                                          'Dulang May Ganap ang Haba', 14),
('2004', 'Pilak, Cultural Center of the Philippines',                                  'Outstanding contribution in Culture and the Arts', 15),
('2001', 'Who''s Who in the World',                                                    'Cambridge Biographical Centre — Millennium Edition', 16),
('2001', '2000 Outstanding Intellectuals of the 21st Century',                         'International Biographical Centre, Cambridge', 17),
('2012', 'Top Ten Outstanding Alumni, Dept. of English',                               'Mindanao State University, celebrating MSU''s Golden Anniversary', 18),
('1999', 'Observation Trip of Young Theater Leaders',                                  'Japan Foundation', 19),
('1993', 'Local Fellow for Drama',                                                     'UP Creative Writing Center, 1993–1994', 20),
('1993', 'Outstanding Citizen Award for Culture and Arts',                             'Iligan Sinulog Jaycee Senate', 21),
('1993', 'Community Leadership Award — Leadership in the Arts and Culture',            'Lanao Press and Radio-TV Club', 22),
('1989', 'Group Study Exchange Scholar',                                               'Rotary International, Northern California and Nevada, USA', 23),
('1989', 'Winner, CCP National Drama Competition',                                     null, 24),
('—',    'Most Awarded Group',                                                         '13th International Folkloric Festival, Port Sur Saone, France', 25),
('—',    'Concourse de Chanson Internationaux',                                        null, 26)
on conflict do nothing;


-- ─────────────────────────────────────────
-- INTERNATIONAL REPRESENTATIONS
-- ─────────────────────────────────────────
insert into representations (year, event, sort_order) values
('2026', 'Sinulog sa Iligan — Iligan City 76th Anniversary', 1),
('2025', 'World Culture Festival, Karnataka, India', 2),
('2024', '72nd Anniversary, Thailand Royalty', 3),
('2023', 'ASEAN Panji Festival, Indonesia', 4),
('2019', 'Mumbai Ramayana International Festival', 5),
('2017', 'India–ASEAN Summit, New Delhi and Kolkata', 6),
('2016', 'Ramayana Plus ASEAN Cultural Festival, Bangkok, Thailand', 7),
('2012–2018', 'UNESCO-ITI Asia-Pacific Bureau Festivals — Taiwan, Vietnam, Shanghai, Singapore', 8),
('2014', 'SUHI International Premiere — Shanghai Theatre Academy', 9),
('2013', 'Ho Chi Minh Philippine Independence Day', 10),
('2012', 'SugaTula (Crossing Poetry) International Premiere — Taipei', 11),
('2009', 'APB Festival, Saigon (Asia Pacific Bond)', 12),
('2007', 'Taipei International Arts Festival — Uwahig', 13),
('2006', 'US Centennial Celebrations, Hawaii and USA', 14),
('2005', 'Asia Meets Asia, Japan', 15),
('2004', 'Reviving Subalternity International Premiere — Taipei', 16),
('2002', 'Philippine National Day, Monte Carlo, Monaco', 17),
('2001', 'Changhua International Traditional Arts Festival; International Hand Drum Music Concert, Taiwan', 18),
('2001', 'World Cup, Daejeon, South Korea', 19),
('1998', 'International Festivals — France, Spain, and Portugal', 20),
('1997', 'Folkloric Festivals — Angers, Haguenau, Remiremont, Strasbourg, France', 21),
('1996', '5th Holten International Folkloric Festival, Netherlands; Stockton Riverside International Festival, UK', 22),
('1994', 'Singapore Festival of the Arts — International Premiere of Tales from Mindanao', 23),
('—',    'International Folkloric Festivals — Belgium, Spain (35th International Mediterranean Festival)', 24),
('—',    'Taiwan–Philippines Products Promotions', 25)
on conflict do nothing;


-- ─────────────────────────────────────────
-- PLAY AWARDS
-- ─────────────────────────────────────────
insert into play_awards (title, detail, sort_order) values
('MingMing',                '1st Place, Don Carlos Palanca Memorial Awards, 2006 (One-Act Play, English)', 1),
('Badung',                  '3rd Place, Don Carlos Palanca Memorial Awards, 2022 (Dulang May Ganap ang Haba)', 2),
('Datu Matu',               'CCP Grant Award, 1992', 3),
('Sarimanok',               'UP Likhaan, 1986; UST Publishing House anthology', 4),
('Patas',                   'CCP Playwriting Workshop Outstanding Play, 1986', 5),
('Ranaw: Isang Alamat',     'CCP Playwriting Award, 1985', 6)
on conflict do nothing;


-- ─────────────────────────────────────────
-- PRODUCTIONS
-- Sourced from productionData.js + ipagarts.com/productions/
-- ─────────────────────────────────────────
insert into productions (
    title, path, image, description, about, history,
    facts, credits, reviews, videos, gallery, sort_order
) values

-- 1. Tales from Mindanao
(
    'Tales from Mindanao',
    '/tales-from-mindanao',
    '/images/TFM2.jpg',
    'The highly-acclaimed international touring repertoire of dance-music stories about Mindanao and its people.',
    'A series of dance-music vignettes pooled from the rich indigenous and folk cultural resources of the Philippines'' southernmost island. This suite is perhaps the Philippines'' most-traveled repertory production, drawing from Higaunon, M''ranao, Christian, and communal performance traditions.',
    'Premiered as Life, Love and Death: Tales From Mindanao at the 1992 1st CCP National Theatre Festival. Since its first appearance and its subsequent international premiere at the 1994 Singapore Festival of the Arts, Tales has performed in extensive road shows representing the Philippines in countless world festivals. International engagements include the Netherlands, Austria, France, United Kingdom, Spain, Portugal, Belgium, Taiwan, South Korea, Singapore, Monaco, and the USA and Hawaiian Islands.',
    '[{"label":"Type","value":"Dance-Music Vignettes"},{"label":"Premiered","value":"1992 — CCP National Theatre Festival"},{"label":"Intl. Premiere","value":"1994 — Singapore Festival of the Arts"}]'::jsonb,
    '[{"role":"Mise-en-Scene","name":"Steven P.C. Fernandez"},{"role":"Choreography","name":"Nolly Ceballos and the IPAG Creative Collective"},{"role":"Associates","name":"Melvin Pascubillo, Leilani Monterola"},{"role":"Music","name":"Steven P.C. Fernandez"},{"role":"Designs","name":"Vicmar Paloma, Hermi Dico"},{"role":"Technical Director","name":"Andrew Salazar"}]'::jsonb,
    '[{"quote":"Grab(s) me fully from their opening seconds: dark stage, figures in shadow, kulintang music beaten out on rows of gongs. The lights come up, dancers in native costume appear — balletic, athletic, poetic — and I feel like I''m looking at images sprung from vestiges of a Jungian collective imagination. Fernandez and his troupe revitalize folk traditions; they show that the traditional is the contemporary.","source":"Tim Tomlinson, President, New York Writers Workshop"},{"quote":"Skillful storytelling via dance… fascinating… not for an instant did audience attention falter.","source":"Leonor Orosa Goquingco, National Artist for Dance"},{"quote":"How exquisitely delightful to watch IPAG steadily increase in stature thru the years! Thoroughly professional, the group exudes an easy confidence and seamless mastery — a natural charm and agility, especially in its vivid storytelling, that mesmerizes and thrills.","source":"Julie Lluch, Philippine Artist"}]'::jsonb,
    '[{"id":"veTvqEw9F3U","title":"Sinulog Suite"},{"id":"snOWpajk8nM","title":"Tale from Mindanao (Condensed)"},{"id":"BnFOCiaS6uY","title":"Tales from Mindanao"}]'::jsonb,
    '["/images/ipag1.png","/images/ipag2.png","/images/ipag3.png","/images/ipag4.png","/images/ipag5.png","/images/ipag6.png"]'::jsonb,
    1
),

-- 2. SITA: The Ramayana Revisited
(
    'SITA: The Ramayana Revisited',
    '/sita',
    '/images/Sita.jpg',
    'A complete cycle of transcreation — a 3,000-year-old epic reformed from Sanskrit into a contemporary Philippine performance.',
    'Between her husband RAMA and abductor LAWANA, SITA weighs her options. She has been freed by Lawana to return to safety but decides to stay to warn Rama of impending danger. She risks being caught between the warring armies. A powerful reflection on courage, compassion, devotion, and conviction.',
    'SITA premiered in the Philippines and made its international debut at the ASEAN Cultural Expo in Bangkok, Thailand in 2016. It has since toured India (Ayodhya, Mumbai, Kolkata, New Delhi), Singapore, and other international stages — touching 5,000 audiences to silence, retrospection, then blasts of exultant applause.',
    '[{"label":"Premiered","value":"2015"},{"label":"Intl. Premiere","value":"2016 — ASEAN Cultural Expo, Bangkok"},{"label":"Type","value":"Dance-Theatre / Transcreation"}]'::jsonb,
    '[{"role":"Book and Mise-en-Scene","name":"Steven P.C. Fernandez"},{"role":"Choreography","name":"IPAG Creative Collective"},{"role":"Choreography Enhancements","name":"Leilani Fernandez and Melvin Pascubillo"},{"role":"Music","name":"Geejay Langois and Steven P.C. Fernandez"},{"role":"Designs","name":"Vicmar Paloma, Hermi Dico, and Tres Cartera"},{"role":"Technical Director","name":"Andrew Salazar"}]'::jsonb,
    '[{"quote":"The stage lit up… a stirring theatrical presentation… a powerful reflection on courage, compassion, and conviction.","source":"One World One Family Mission, Karnataka, India"},{"quote":"A unique piece… from the core of your heart and respect. Your performance was not only magnificent but also divine.","source":"Anita Bose, Ramayana scholar and author"},{"quote":"Fascinating…. I was enthralled by the performance.","source":"Anand Neelakantan, award-winning novelist-screenwriter, Mumbai"},{"quote":"Powerful, energetic, flamboyant… oh! What a performance. They left the audience gasping and wanting for more. They truly stole the show.","source":"Indian Council on Cultural Relations, New Delhi"},{"quote":"The Philippines'' Ramayana was the best… India should watch your Ramayana.","source":"Dr. Saroja Vaidyanathan, foremost Bharatanatyan guru, India"}]'::jsonb,
    '[{"id":"5YUr7J0ekdg","title":"Sita Bangalore Finale"},{"id":"sdDkdXSaoCE","title":"Sita: The Ramayana Revisited (Condensed)"},{"id":"uZ93pPXsVlQ","title":"IPAG \"Sita: The Ramayana Revisited\""}]'::jsonb,
    '["/images/ipag1.png","/images/ipag2.png","/images/ipag3.png","/images/ipag4.png","/images/ipag5.png","/images/ipag6.png"]'::jsonb,
    2
),

-- 3. Three Peoples, One Island (Tatlo sa Isa)
(
    'Three Peoples, One Island',
    '/tatlo-sa-isa',
    '/images/tatlo.png',
    'Three peoples, one island — a performance about the shared identities and cultural crossings of Mindanao.',
    'A production celebrating the communities and cultural memories that shape one island. Tatlo sa Isa brings together the Christian, Muslim, and indigenous peoples of Mindanao in a celebration of shared identity and coexistence.',
    'Part of IPAG''s 49th Season program of productions, roadshows, workshops, and performance courses on the road to the Guild''s golden anniversary in 2027. Originally premiered in 1991 alongside Tales From Mindanao as Buhay, Pag-ibig, at Kamatayan: Mga Kwentong Mindanao.',
    '[{"label":"Season","value":"49th Season (2026–2027)"},{"label":"Type","value":"Dance-Theatre"},{"label":"Origin","value":"Mindanao, Philippines"}]'::jsonb,
    '[]'::jsonb,
    '[]'::jsonb,
    '[{"id":"qG8HV8H-rVI","title":"Tatlo sa Isa (Three Peoples, One Island)"}]'::jsonb,
    '["/images/ipag1.png","/images/ipag2.png","/images/ipag3.png","/images/ipag4.png","/images/ipag5.png","/images/ipag6.png"]'::jsonb,
    3
),

-- 4. Sarimanok
(
    'Sarimanok',
    '/sarimanok',
    '/images/ipag2.png',
    'IPAG''s signature production — inspired by the M''ranao bird of wealth and prestige, a legendary bird learns to fly and challenges the harsh laws of tradition.',
    'Inspired by the M''ranao pseudo-bird icon of wealth and prestige, the musical narrates of a legendary bird whose responsibility is to feed the flock. Learning how to fly through a vagabond Ibon who accidentally stumbles on their land of Bayang Lawa, Sarimanok oversteps tradition. The harsh laws deal her the ultimate punishment for her transgressions.',
    'Composed in 1980, inspired by Bach''s Jonathan Livingston Seagull. Its premiere had to be cancelled when the Iligan plaza was bombed claiming several lives. The year after (August 1981), it took the Silliman audience by storm. Featured in UP''s Diamond Jubilee celebrations in 1982. Sarimanok became IPAG''s signature production, touring Europe and Asia and receiving distinctions from the CCP. It headlines IPAG''s 50th Year (2027–28).',
    '[{"label":"Composed","value":"1980"},{"label":"Premiered","value":"August 1981 — Silliman University"},{"label":"Remounts","value":"1989, 2013"}]'::jsonb,
    '[{"role":"Book and Mise-en-Scene","name":"Steven P.C. Fernandez"},{"role":"Music","name":"Steven P.C. Fernandez"},{"role":"Choreography (2013)","name":"Leilani M. Fernandez, Melvin Pascubillo"},{"role":"Original Choreography","name":"Juliet Celeste F. Malit"},{"role":"Designs","name":"Hermi Dico and Jeff Umbay"},{"role":"Technical Director","name":"Mark Saura"}]'::jsonb,
    '[{"quote":"A coup d''theatre.","source":"Albert Faurot"},{"quote":"Strong and definite directorial vision… complete and whole.","source":"Doreen G. Fernandez, Theatre Historian"},{"quote":"So spontaneous, freed by a mastery that easily engaged the audience.","source":"Esteban Basilio Villaruz, Philippine''s foremost dance scholar"}]'::jsonb,
    '[{"id":"OMtsYqRHjLE","title":"Sarimanok Trailer"}]'::jsonb,
    '["/images/ipag1.png","/images/ipag2.png","/images/ipag3.png","/images/ipag4.png","/images/ipag5.png","/images/ipag6.png"]'::jsonb,
    4
),

-- 5. MarLen
(
    'MarLen',
    '/marlen',
    '/images/ipag3.png',
    'A father meets his daughter for the last time in an isolated forest — a play about conflict, politics, and ideology fracturing a family and a nation.',
    'Journalist Mario meets Marlen after a decade apart, as she faces the consequences of joining a rebel movement. The narrative moves through a collage of images, overlapping actions and spaces, combining the supernatural with the physical. The play raises questions about the reason for conflict spurred by politics and ideology.',
    'MarLen uses postmodern methods to compose a collage of myth and realism. The dramaturgy moves through images as Fernandez has used in past works — overlapping mediums, devising movements, and combining the supernatural with the physical. No play is ever complete as it goes through a shared consciousness that is constantly changing. Premiered 2024.',
    '[{"label":"Premiered","value":"2024"},{"label":"Type","value":"Contemporary Theatre"},{"label":"Style","value":"Myth and Realism / Postmodern"}]'::jsonb,
    '[{"role":"Direction and Playwriting","name":"Steven P.C. Fernandez"}]'::jsonb,
    '[{"quote":"Phew! What a great performance and story!… Perfect ang cast, ang music, ang acting! Music, script, production design… A must-watch (experience)!","source":"Yvette Marie Sabellona, Creative Industry Council, Iligan"}]'::jsonb,
    '[{"id":"R0wnDNIHyZo","title":"MarLen Video Collage"}]'::jsonb,
    '["/images/ipag1.png","/images/ipag2.png","/images/ipag3.png","/images/ipag4.png","/images/ipag5.png","/images/ipag6.png"]'::jsonb,
    5
),

-- 6. Hapoy Daw Waig
(
    'Hapoy Daw Waig',
    '/hapoy',
    '/images/ipag4.png',
    'A Mindanao epic of resistance, exile, and hope — Agyu''s people resist oppressive taxation and search for paradise.',
    'Under oppressive taxation, Agyu''s community resists the tyranny of the Sultan of Maguindanao. Negotiating to ease the tax demands, KUYASU angrily spears the Sultan dead, instigating war. Hope lies in MUNGAN, too sick to evacuate, but empowered by the diwatas — she holds the secret of the exodus to Nilandangan, their paradise, via the magical boat, the Sarimbar.',
    'The production draws from the researches of Mila Aguilar, Carmen Unabia, and Elena Maquiso, transforming epic Bukidnon narratives into a theatrical journey across mountains and memory. Premiered in 2023. A revised version, Hapoy daw Waig (Fire and Water), premiered in 2023 as part of the 49th Season.',
    '[{"label":"Premiered","value":"2011 / Revised 2023"},{"label":"Source","value":"Bukidnon Epic Narratives (Ulahingan)"},{"label":"Type","value":"Epic Theatre / Dance-Music"}]'::jsonb,
    '[{"role":"Book, Mise-en-Scene, and Music","name":"Steven P.C. Fernandez"},{"role":"Chant Music","name":"Michael Lagura"},{"role":"Choreography","name":"Leilani Fernandez and IPAG Creative Collective"},{"role":"Asst. Director","name":"Neil Arkhe Azcuna"},{"role":"Designs","name":"Archibald Pacana and the IPAG Design Cluster"}]'::jsonb,
    '[{"quote":"Unique, spectacular… you are the keepers of the past and holders of the future. Awesome.","source":"Barmasah Kiprop Titus, Nairobi, Kenya"}]'::jsonb,
    '[]'::jsonb,
    '["/images/ipag1.png","/images/ipag2.png","/images/ipag3.png","/images/ipag4.png","/images/ipag5.png","/images/ipag6.png"]'::jsonb,
    6
),

-- 7. Datu Matu
(
    'Datu Matu',
    '/datu',
    '/images/ipag5.png',
    'A story of clan loyalty, resistance, and survival during the American occupation of Mindanao.',
    'American troops enter the village of Gumbaran as the community of DATU MATU celebrates his son''s passage towards manhood. Arch enemy DATU AWALO unites with Matu through betrothal to end a long rido (feud). As Matu reluctantly complies with American decrees under the pressure of law and firepower, Awalo willingly collaborates. Betrayal, resistance, and the destruction of a community follow.',
    'Premiered in 1995, Datu Matu depicts the historical tensions during the American colonial period in Mindanao. The production uses pangalay movements stylized for effect in synchronized choreography, earning recognition from international critics. Awarded the CCP Grant Award, 1992.',
    '[{"label":"Premiered","value":"1995"},{"label":"Period","value":"American Colonial Era"},{"label":"Type","value":"Historical Theatre / Dance-Music"}]'::jsonb,
    '[{"role":"Mise-en-Scene, Libretto, and Music","name":"Steven P.C. Fernandez"},{"role":"Choreography and Dance Training","name":"Melvin Pascubillo, Leilani Monterola, and IPAG Creative Collective"},{"role":"Designs","name":"Archibald Joel Pacana"},{"role":"Lighting Design","name":"Vicmar Paloma"},{"role":"Technical Director","name":"Andrew Salazar"}]'::jsonb,
    '[{"quote":"The show in itself is worth the trip from Europe.","source":"Honorary Professor Ludwig Streit, Germany"},{"quote":"The integrity of the play is evident from the start… presented with consummate ease… showing IPAG''s perfection of the use of pangalay movements stylized for effect in synchronized choreography.","source":"Philippine Daily Inquirer"}]'::jsonb,
    '[{"id":"zt1n2Mi3WZc","title":"\"Datu Matu\" sabil scene"}]'::jsonb,
    '["/images/ipag1.png","/images/ipag2.png","/images/ipag3.png","/images/ipag4.png","/images/ipag5.png","/images/ipag6.png"]'::jsonb,
    7
),

-- 8. Suhi
(
    'Suhi',
    '/suhi',
    '/images/ipag6.png',
    'A Philippine deconstruction of Sophocles'' Oedipus Rex — clan wars, fratricide, and lives fated to be doomed.',
    'The clan wars. The scramble for domination. Fratricide. Lives fated to be doomed. Amid the chaos are secrets too shocking to reveal. Drawing the full house into a maelstrom of conspiracy and duplicity, SUHI (Breech Birth) deconstructs the Oedipus tale through Philippine performance — silences, refrains, movement, and personal truths.',
    'Premiered in 2010, SUHI made its international premiere in Shanghai in 2014. The play ends with the yet unfulfilled half of the Oedipal oracle — as Udin learns he has married his own mother, he also realizes he is the son of his archenemy.',
    '[{"label":"Premiered","value":"2010"},{"label":"Intl. Premiere","value":"2014 — Shanghai"},{"label":"Source","value":"Sophocles'' Oedipus Rex"}]'::jsonb,
    '[{"role":"Play, Mise-en-Scene, and Music","name":"Steven P.C. Fernandez"},{"role":"Choreography","name":"Leilani M. Fernandez"},{"role":"Designs","name":"Vicmar Paloma, Hermie Dico, Clint Jordan Sabate"},{"role":"Associate Directors","name":"John Michael Lagura, Blesy Cece"}]'::jsonb,
    '[{"quote":"SUHI is incredible. The refrains, the stage, the crescendos, the silences, the final tableau — everything speaks. I love that each character could not help but operate in his own personal truth. Steven P.C. Fernandez, you ARE a genius.","source":"Honeylet Dumoran, Associate Professor of Linguistics, MSU-IIT"},{"quote":"Congratulations… bold attempt to present another play disturbing the consciousness of the audience; the excellent bayanihan spirit of IPAG; the promising acting of newcomers… and seasoned performances.","source":"Christine Godinez-Ortega DFA, poet and Founding Director, Iligan National Writers Workshop"}]'::jsonb,
    '[{"id":"2Xk22c0OI18","title":"Suhi by IPAG"},{"id":"X4rLUcPTQRU","title":"SUHI, a play by Steven Patrick C. Fernandez"}]'::jsonb,
    '["/images/ipag1.png","/images/ipag2.png","/images/ipag3.png","/images/ipag4.png","/images/ipag5.png","/images/ipag6.png"]'::jsonb,
    8
),

-- 9. Uwahig
(
    'Uwahig',
    '/uwahig',
    '/images/isaulog.jpg',
    'A deconstructed genesis combining the Indarapatra-Sulayman Maguindanaon epic and Bukidnon flood myths.',
    'INDARAPATRA begs his brother SULAYMAN to save Mindanao from destruction. When the giant crabs fall to earth, the waters overflow. Sulayman battles the curses — the kurita, the bird-like tarabusaw, and the monstrous pah. Distressed by his brother''s death, Indarapatra continues the fight against the seven-headed bird. In the end, the people carry the remains of the brothers to the distant horizon.',
    'Uwahig premiered for the UNESCO-ITI festival at the CCP in 2006 and has since performed in national and international festivals including the Asia Pacific Bond in Saigon and the Taipei Arts Festival (2007). The production transcreates a deconstructed genesis of pre-settler life, eschewing dialogue altogether and preferring haunting elemental noises alongside a neo-ethnic techno score.',
    '[{"label":"Premiered","value":"2006 — UNESCO-ITI Festival, CCP"},{"label":"Intl. Premiere","value":"2007 — Taipei Arts Festival"},{"label":"Source","value":"Maguindanaon and Bukidnon Epics"}]'::jsonb,
    '[{"role":"Book and Direction","name":"Steven P.C. Fernandez"},{"role":"Music","name":"Geejay Williams and Mebuyan"},{"role":"Choreography","name":"Felimon Blanco, Melvin Pascubillo, and IPAG Creative Collective"}]'::jsonb,
    '[{"quote":"Very good…. I could not keep my discomfort… amazing how people — especially those in Europe — have disregarded the issues you presented.","source":"Tobias Biancone, UNESCO-ITI, Secretary General"},{"quote":"The epic of Indarapatra and Sulayman, whose cosmic battles became a metaphor for the modern-day decimation of parts of Mindanao… boldly challenged conventionality by eschewing dialogue altogether… throb(s) with native vibrancy and spirit.","source":"Gibbs Cadiz, The Philippine Daily Inquirer"},{"quote":"Very beautiful… very intense.","source":"Jeff Janisheski, National Institute of Dramatic Arts (NIDA), Australia"},{"quote":"Very lovely… wonderful storytelling!","source":"Edith Podesta, La Salle College of the Arts, Singapore"}]'::jsonb,
    '[{"id":"lLT9BpAUJas","title":"Uwahig (Water)"},{"id":"5IStZYF3x0g","title":"PROLOGUE Uwahig"}]'::jsonb,
    '["/images/ipag1.png","/images/ipag2.png","/images/ipag3.png","/images/ipag4.png","/images/ipag5.png","/images/ipag6.png"]'::jsonb,
    9
),

-- 10. Isaulog, The Iligan Story
(
    'Isaulog, The Iligan Story',
    '/isaulog',
    '/images/isaulog.jpg',
    'A celebration of Iligan City — its people, history, and spirit.',
    'Isaulog tells the story of Iligan City through movement, music, and theatre. A testament to the resilience and culture of the people of Iligan, this production honors the city that has been IPAG''s home for nearly five decades.',
    'The newest addition to IPAG''s repertoire, Isaulog premiered in 2025 as part of the Guild''s ongoing commitment to celebrating Mindanao''s rich cultural heritage on the road to its golden anniversary. IPAG performed Tales From Mindanao at an outdoor performance at the Iligan City hall area in June 2026 to celebrate Iligan''s 76th Anniversary.',
    '[{"label":"Premiered","value":"2025"},{"label":"Type","value":"Dance-Theatre"},{"label":"Setting","value":"Iligan City, Philippines"}]'::jsonb,
    '[]'::jsonb,
    '[]'::jsonb,
    '[]'::jsonb,
    '["/images/ipag1.png","/images/ipag2.png","/images/ipag3.png","/images/ipag4.png","/images/ipag5.png","/images/ipag6.png"]'::jsonb,
    10
),

-- 11. Ranaw: Isang Alamat
(
    'Ranaw: Isang Alamat',
    '/ranaw',
    '/images/ipag1.png',
    'A legend of Lake Lanao — IPAG''s CCP Award-winning play, restaged for the 49th Season.',
    'Ranaw: Isang Alamat (Ranaw: A Legend) is rooted in the Maranao oral tradition surrounding Lake Lanao. The production was IPAG''s first major CCP recognition and anchored the Guild''s long relationship with the country''s premier cultural institution.',
    'Premiered in 1985 with the CCP Playwriting Award. Ranaw chained IPAG''s engagements with the Cultural Center of the Philippines through the decades. It is restaged as part of the 49th Season on the road to IPAG''s golden anniversary in 2027.',
    '[{"label":"Premiered","value":"1985"},{"label":"Award","value":"CCP Playwriting Award, 1985"},{"label":"Season","value":"Restaged — 49th Season 2026–2027"}]'::jsonb,
    '[{"role":"Book and Direction","name":"Steven P.C. Fernandez"}]'::jsonb,
    '[]'::jsonb,
    '[]'::jsonb,
    '["/images/ipag1.png","/images/ipag2.png","/images/ipag3.png","/images/ipag4.png","/images/ipag5.png","/images/ipag6.png"]'::jsonb,
    11
),

-- 12. Orpheus Trilogy
(
    'Orpheus Trilogy',
    '/orpheus',
    '/images/ipag2.png',
    'A Philippine reimagining of the Orpheus myth — premiered internationally at the Shanghai Theatre Academy.',
    'The Orpheus Trilogy brings the ancient Greek myth into the landscape of Philippine performance, refracted through IPAG''s methods of Transcreation and Distillation.',
    'Premiered in 2017 with its international premiere at the Shanghai Theatre Academy.',
    '[{"label":"Premiered","value":"2017"},{"label":"Intl. Premiere","value":"Shanghai Theatre Academy, 2017"},{"label":"Type","value":"Dance-Theatre / Transcreation"}]'::jsonb,
    '[{"role":"Direction","name":"Steven P.C. Fernandez"}]'::jsonb,
    '[]'::jsonb,
    '[]'::jsonb,
    '["/images/ipag1.png","/images/ipag2.png","/images/ipag3.png","/images/ipag4.png","/images/ipag5.png","/images/ipag6.png"]'::jsonb,
    12
),

-- 13. Tighod
(
    'Tighod',
    '/tighod',
    '/images/ipag3.png',
    'Tides of Times — a production that journeys through eras of Philippine history and memory.',
    'Tighod (Tides of Times) weaves together historical and contemporary strands of Philippine experience, examining how communities persist through upheaval and change.',
    'Premiered in 2019 with its international premiere at the APB Festival in Hanoi, Vietnam.',
    '[{"label":"Premiered","value":"2019"},{"label":"Intl. Premiere","value":"APB Festival, Hanoi, 2019"},{"label":"Type","value":"Dance-Theatre"}]'::jsonb,
    '[{"role":"Direction","name":"Steven P.C. Fernandez"}]'::jsonb,
    '[]'::jsonb,
    '[]'::jsonb,
    '["/images/ipag1.png","/images/ipag2.png","/images/ipag3.png","/images/ipag4.png","/images/ipag5.png","/images/ipag6.png"]'::jsonb,
    13
)
on conflict (path) do nothing;


-- ─────────────────────────────────────────
-- PAGE CONTENT — key blocks editable from admin
-- ─────────────────────────────────────────
insert into page_content (page, key, value) values

-- Home page
('home', 'hero_poster_image',  '/images/49th-Theater-Season.png'),
('home', 'hero_poster_alt',    'IPAG 49th Theater Season poster'),
('home', 'intro_kicker',       'The IPAG'),
('home', 'intro_title',        'Stories from the South. Shared with the world.'),
('home', 'intro_body',         'Founded in 1978 in Iligan City, the Integrated Performing Arts Guild is one of the Philippines'' most-traveled and most-awarded performing companies. IPAG brings together theater, dance, music, literature, and visual design to tell stories rooted in Southern Philippine cultures.'),
('home', 'season_kicker',      'August 2026 – May 2027'),
('home', 'season_title',       '49th Season: On the road to Gold'),
('home', 'season_body',        'In August 2027, IPAG turns fifty. This season celebrates the legacy, people, and creative work that carry the Guild toward its golden anniversary.'),
('home', 'season_count',       '4'),
('home', 'story1_kicker',      'Performance and practice'),
('home', 'story1_heading',     'Hagup sa Kasinatian'),
('home', 'story1_para1',       'IPAG Studies brings together Praxis, Pedagogy, Production, and Aesthetics. Its performance practice grows from local lore, indigenous forms, oral literature, music, and the living communities of North-Central Mindanao.'),
('home', 'story1_para2',       'The Guild''s work bridges education, culture, and the arts, creating learning experiences for students, educators, artists, and audiences at home and abroad.'),
('home', 'story2_kicker',      'Recognition'),
('home', 'story2_heading',     'A company built beyond the center'),
('home', 'story2_para1',       'IPAG has performed in more than a hundred cities and festivals worldwide, receiving distinctions including the CCP Gawad para sa Sining, CCP Gador, UMPIL awards, NCCA SUDI Music Award, and international honors from India, Spain, and the International Theatre Institute.'),
('home', 'contact_kicker',     'Bring IPAG to your venue'),
('home', 'contact_heading',    'Plan a performance, road show, or workshop.'),
('home', 'contact_address',    'IPAG Center, Ramiro St., Ilaya, Poblacion, Iligan City'),
('home', 'contact_email',      'ipagarts@gmail.com'),
('home', 'contact_phone',      '(+63) 917 136 2275'),

-- Mission & Vision page
('mission-vision', 'mission',     'To create, preserve, and share the living performance traditions of Mindanao and the Philippines — bringing theater, dance, music, literature, and visual design into a unified artistic practice committed to truthful storytelling and the elevation of indigenous and folk traditions to the world stage.'),
('mission-vision', 'vision',      'A Philippines recognized globally for the depth, beauty, and humanity of its performing arts — where the stories and traditions of Mindanao are celebrated alongside the great theatrical traditions of the world.'),

-- IPAG Studies page
('ipag-studies', 'intro',         'INTEGRATED PERFORMING ARTS GUILD – ARTIST RESOURCE MANAGEMENT, INC. (IPAG-ARM, Inc.), through its INSTITUTE FOR PERFORMING AND ART GENRE STUDIES (IPAG-S) implements the Culture-Arts initiative of TESDA. Philippines'' pioneering Culture-Arts Academy, whose framework and pedagogy are derived from IPAG practices, empowers our Creative Industry and fulfills the economic demands of the 21st Century, where creativity and imagination are our power tools.'),
('ipag-studies', 'tesda_note',    'TESDA Region X awarded the Certificate of TVET Program Registration for The Basic in Performing Arts under the Enterprise-Based Education and Training (EBET) Program to IPAG-ARM. CTPR RPTP No. EBET-Upskilling-2026-10-35-CRE000000-037.'),

-- History page
('history', 'founding_para1',     'The Integrated Performing Arts Guild was founded in 1978 in Iligan City, Mindanao, by Steven P.C. Fernandez and co-founder Ligaya Fernando-Amilbangsa — beginning with a small group of twelve artists, the original IPAG 12. IPAG''s story is a model of fortitude, resilience, and conquest as it journeys towards its Gold Year in 2027.'),
('history', 'founding_para2',     'For its first 46 seasons, IPAG was hosted by the Mindanao State University–Iligan Institute of Technology (MSU-IIT), which provided the Guild a home as it grew into a nationally recognized and internationally touring performing company. Beginning with its 47th season, IPAG operates independently, continuing its mission as a major Philippine performing company.'),

-- Milestones page
('milestones', 'intro_para1',     'On July 7, 2022, the Cultural Center of the Philippines awarded IPAG and its Artistic Director Steven P.C. Fernandez with the 1st Gador Awards. The CCP would later award IPAG the Gawad para sa Sining — the highest distinction for a performing company — in a ceremony at the CCP Tanghalang Abelardo.'),
('milestones', 'intro_para2',     'These honors recall the artists, institutions, and communities that have shaped IPAG: its home, the MSU–Iligan Institute of Technology; co-founder Ligaya Fernando-Amilbangsa; the original IPAG 12; and the multitude of supporters and audiences across the Philippines and the world.'),

-- Bookings page
('bookings', 'intl_contact_name',  'Stanley Perry C. Fernandez'),
('bookings', 'intl_contact_phone', '(+63) 977 031 4669 / (63) 921 414 6179'),
('bookings', 'intl_contact_email', 'fernandezstanleyperry@gmail.com'),
('bookings', 'local_contact_name', 'Arlem M. Abanes'),
('bookings', 'local_contact_phone','(+63) 917 136 2275 / 229-5178'),
('bookings', 'local_contact_email','ipagarts@gmail.com'),

-- Contact page
('contact', 'address',            'IPAG Center, Ramiro St., Ilaya, Poblacion, Iligan City, Philippines'),
('contact', 'email',              'ipagarts@gmail.com'),
('contact', 'phone',              '(+63) 917 136 2275'),
('contact', 'logo_credit',        'The IPAG logo and its mast are designed by pioneering Resident Visual Arts Advisor Dennis Orellana. The font in the IPAG mast is credited to pioneering researcher-visual artist Dionisio Orellana, also a Founding staff of the MSU Research Center (now renamed the Mamatua Saber Center in Marawi City). The IPAG mast font is commonly referred to as the "Orellana Font."')
on conflict (page, key) do nothing;
