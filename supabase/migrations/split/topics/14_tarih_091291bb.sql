begin;
insert into topic_contents (topic_id, summary, content_md, example_question) values ('091291bb-a136-48e2-94b1-8d12631be6ad', 'Kurtuluş Savaşı (Millî Mücadele), Mondros Ateşkes Antlaşması sonrası işgallere karşı Mustafa Kemal önderliğinde örgütlenen direniş sürecidir; kongreler, TBMM''nin açılışı, cepheler ve Lozan Antlaşması''yla sonuçlanmıştır.', '## Hazırlık Dönemi
- 30 Ekim 1918''de Mondros Ateşkes Antlaşması imzalanmış, İtilaf Devletleri Anadolu''yu işgale başlamıştır.
- 19 Mayıs 1919''da Mustafa Kemal, Millî Mücadele''yi örgütlemek üzere Samsun''a çıkmıştır.

## Kongreler ve Genelgeler
- 22 Haziran 1919''da yayımlanan Amasya Genelgesi, "Milletin istiklalini yine milletin azim ve kararı kurtaracaktır" ifadesiyle Millî Mücadele''nin ilk yazılı belgesi kabul edilir.
- Temmuz-Ağustos 1919''da toplanan Erzurum Kongresi bölgesel, Eylül 1919''da toplanan Sivas Kongresi ise ulusal nitelikli bir kongredir; Sivas Kongresi''nde Anadolu ve Rumeli Müdafaa-i Hukuk Cemiyeti kurulmuştur.

## TBMM''nin Açılışı ve Misak-ı Millî
- Son Osmanlı Mebusan Meclisi''nde kabul edilen Misak-ı Millî kararları, millî sınırları ve bağımsızlık ilkelerini belirlemiştir.
- İstanbul''un İtilaf Devletlerince resmen işgal edilmesi (16 Mart 1920) üzerine, 23 Nisan 1920''de Ankara''da TBMM açılmıştır.

## Cepheler
- **Doğu Cephesi:** Kazım Karabekir komutasında Ermenilere karşı mücadele edilmiş, Gümrü Antlaşması ile sonuçlanmıştır.
- **Güney Cephesi:** Kuvay-ı Milliye güçleri Fransızlara karşı Antep, Maraş ve Urfa''da direnmiştir.
- **Batı Cephesi:** Yunan ordusuna karşı I. İnönü (Ocak 1921) ve II. İnönü (Mart-Nisan 1921) muharebeleri kazanılmış, Ağustos-Eylül 1921''de Sakarya Meydan Muharebesi ile Yunan ilerleyişi durdurulmuştur. 26 Ağustos 1922''de başlayan Büyük Taarruz ve 30 Ağustos''taki Başkomutanlık Meydan Muharebesi ile Yunan ordusu kesin olarak yenilgiye uğratılmıştır.

## Savaşın Sonuçları
- Ekim 1922''de Mudanya Ateşkes Antlaşması imzalanmıştır.
- 24 Temmuz 1923''te imzalanan Lozan Antlaşması ile yeni Türk devletinin bağımsızlığı uluslararası alanda tanınmıştır.', 'Millî Mücadele''nin ilk yazılı belgesi olarak kabul edilen ve 22 Haziran 1919''da yayımlanan genelge hangisidir?') on conflict (topic_id) do update set summary = excluded.summary, content_md = excluded.content_md, example_question = excluded.example_question;
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('de6d3e81-cd7a-4949-93d3-580348c46dd3', '091291bb-a136-48e2-94b1-8d12631be6ad', 'kolay'::difficulty_level, 'Mustafa Kemal''in Millî Mücadele''yi başlatmak amacıyla Samsun''a çıktığı tarih aşağıdakilerden hangisidir?', 'Millî Mücadele''nin başlangıç tarihini bilir.', 'Mustafa Kemal, 19 Mayıs 1919''da Samsun''a çıkarak Millî Mücadele''nin fiilen başlamasını sağlamıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('de6d3e81-cd7a-4949-93d3-580348c46dd3', '19 Mayıs 1919', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('de6d3e81-cd7a-4949-93d3-580348c46dd3', '23 Nisan 1920', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('de6d3e81-cd7a-4949-93d3-580348c46dd3', '30 Ekim 1918', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('de6d3e81-cd7a-4949-93d3-580348c46dd3', '29 Ekim 1923', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('7347df83-92d4-4a37-8422-6a9da881f470', '091291bb-a136-48e2-94b1-8d12631be6ad', 'kolay'::difficulty_level, 'Türkiye Büyük Millet Meclisi (TBMM) hangi tarihte Ankara''da açılmıştır?', 'TBMM''nin açılış tarihini ve önemini bilir.', 'TBMM, İstanbul''un işgali üzerine 23 Nisan 1920''de Ankara''da açılmıştır.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7347df83-92d4-4a37-8422-6a9da881f470', '23 Nisan 1920', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7347df83-92d4-4a37-8422-6a9da881f470', '19 Mayıs 1919', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7347df83-92d4-4a37-8422-6a9da881f470', '4 Eylül 1919', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7347df83-92d4-4a37-8422-6a9da881f470', '16 Mart 1920', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('084abb6b-6449-404e-858e-2e74220463dd', '091291bb-a136-48e2-94b1-8d12631be6ad', 'orta'::difficulty_level, '"Milletin istiklalini yine milletin azim ve kararı kurtaracaktır" ifadesinin yer aldığı ve Millî Mücadele''nin ilk yazılı belgesi kabul edilen genelge aşağıdakilerden hangisidir?', 'Amasya Genelgesi''nin içeriğini ve önemini kavrar.', 'Bu ifade, 22 Haziran 1919''da yayımlanan Amasya Genelgesi''nde yer almaktadır ve genelge Millî Mücadele''nin ilk yazılı belgesi kabul edilir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('084abb6b-6449-404e-858e-2e74220463dd', 'Amasya Genelgesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('084abb6b-6449-404e-858e-2e74220463dd', 'Erzurum Kongresi kararları', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('084abb6b-6449-404e-858e-2e74220463dd', 'Sivas Kongresi kararları', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('084abb6b-6449-404e-858e-2e74220463dd', 'Misak-ı Millî', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('4bd616d6-92d2-4ad0-954d-f0f9462ae483', '091291bb-a136-48e2-94b1-8d12631be6ad', 'orta'::difficulty_level, 'Batı Cephesi''nde Yunan ordusuna karşı Ağustos-Eylül 1921''de kazanılan ve Türk ordusunun savunmadan taarruza geçişinin başlangıcı sayılan meydan muharebesi hangisidir?', 'Batı Cephesi''ndeki muharebelerin kronolojik sırasını ve önemini bilir.', 'Sakarya Meydan Muharebesi, Ağustos-Eylül 1921''de kazanılmış ve Yunan ilerleyişini durdurarak Türk ordusunun taarruz gücüne geçmesinde dönüm noktası olmuştur.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4bd616d6-92d2-4ad0-954d-f0f9462ae483', 'Sakarya Meydan Muharebesi', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4bd616d6-92d2-4ad0-954d-f0f9462ae483', 'I. İnönü Muharebesi', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4bd616d6-92d2-4ad0-954d-f0f9462ae483', 'Büyük Taarruz', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('4bd616d6-92d2-4ad0-954d-f0f9462ae483', 'II. İnönü Muharebesi', false, 3);
insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ('7502dd5d-7833-4802-b250-20bfc6f5ec28', '091291bb-a136-48e2-94b1-8d12631be6ad', 'zor'::difficulty_level, 'Kurtuluş Savaşı''nda Güney Cephesi''nde Fransız kuvvetlerine karşı Kuvay-ı Milliye direnişinin öne çıktığı yerler aşağıdakilerden hangisinde doğru verilmiştir?', 'Kurtuluş Savaşı cephelerini ve mücadele edilen devletleri doğru eşleştirir.', 'Antep, Maraş ve Urfa, Güney Cephesi''nde Fransızlara karşı verilen direnişin öne çıktığı yerlerdir; Sakarya, İnönü ve Dumlupınar ise Batı Cephesi''nde Yunanlılara karşı yaşanan muharebe yerleridir.');
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7502dd5d-7833-4802-b250-20bfc6f5ec28', 'Antep, Maraş, Urfa', true, 0);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7502dd5d-7833-4802-b250-20bfc6f5ec28', 'Sakarya, İnönü, Dumlupınar', false, 1);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7502dd5d-7833-4802-b250-20bfc6f5ec28', 'Gümrü, Kars, Sarıkamış', false, 2);
insert into question_choices (question_id, choice_text, is_correct, order_index) values ('7502dd5d-7833-4802-b250-20bfc6f5ec28', 'İzmir, Bursa, Eskişehir', false, 3);
commit;