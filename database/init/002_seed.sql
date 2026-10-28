-- ============================================================================
-- CineVerse — демонстраційні дані для розробки та ручного тестування.
-- Використовуйте фіксовані UUID нижче для передбачуваності при тестуванні API.
-- ============================================================================

-- Жанри
INSERT INTO "Genres" ("Id", "Name") VALUES
    ('a0000000-0000-0000-0000-000000000001', 'Фантастика'),
    ('a0000000-0000-0000-0000-000000000002', 'Драма'),
    ('a0000000-0000-0000-0000-000000000003', 'Бойовик'),
    ('a0000000-0000-0000-0000-000000000004', 'Комедія'),
    ('a0000000-0000-0000-0000-000000000005', 'Анімація');

-- Актори
INSERT INTO "Actors" ("Id", "Name") VALUES
    ('a1000000-0000-0000-0000-000000000001', 'Метью МакКонагі'),
    ('a1000000-0000-0000-0000-000000000002', 'Енн Гетевей'),
    ('a1000000-0000-0000-0000-000000000003', 'Кіллан Мерфі');

-- Фільми
INSERT INTO "Movies" ("Id", "Title", "Description", "Duration", "ReleaseDate", "AgeRating", "PosterUrl", "TrailerUrl", "Status") VALUES
    ('b0000000-0000-0000-0000-000000000001', 'Інтерстеллар',
     'Команда дослідників подорожує крізь червоточину в пошуках нового дому для людства.',
     169, '2014-11-06', '12+', 'http://www.impawards.com/2014/posters/interstellar_ver7_xlg.jpg',
     'https://www.youtube.com/watch?v=2LqzF5WauAw', 'NOW_SHOWING'),
    ('b0000000-0000-0000-0000-000000000002', 'Оппенгеймер',
     'Історія фізика Роберта Оппенгеймера та створення атомної бомби.',
     180, '2023-07-21', '16+', 'http://www.impawards.com/2023/posters/oppenheimer_xlg.jpg',
     'https://www.youtube.com/watch?v=keydELfWuMQ', 'NOW_SHOWING'),
    ('b0000000-0000-0000-0000-000000000003', 'Дюна: Частина третя',
     '«Дюна: Частина третя» — за романом Френка Герберта «Месія Дюни», епічний фінал трилогії Дені Вільньова. Минуло майже двадцять років відколи Пол Атрейдес став правителем Імперіуму. Тепер, зіткнувшись із наслідками свого правління, він має протистояти новим загрозам, зраді та змові навколо Чані.',
     165, '2026-12-18', '16+', 'https://multiplex.ua/images/f6/02/f60215444703c9f231693ad9edb61f64.jpeg',
     'https://www.youtube.com/watch?v=RXZhOVd5WWM', 'COMING_SOON');

INSERT INTO "MovieGenres" ("MovieId", "GenreId") VALUES
    ('b0000000-0000-0000-0000-000000000001', 'a0000000-0000-0000-0000-000000000001'),
    ('b0000000-0000-0000-0000-000000000001', 'a0000000-0000-0000-0000-000000000002'),
    ('b0000000-0000-0000-0000-000000000002', 'a0000000-0000-0000-0000-000000000002'),
    ('b0000000-0000-0000-0000-000000000003', 'a0000000-0000-0000-0000-000000000001'),
    ('b0000000-0000-0000-0000-000000000003', 'a0000000-0000-0000-0000-000000000003');

INSERT INTO "MovieActors" ("MovieId", "ActorId", "CharacterName") VALUES
    ('b0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'Купер'),
    ('b0000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000002', 'Амелія Бренд'),
    ('b0000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000003', 'Роберт Оппенгеймер');

-- Кінотеатр і зали (мережа з 5 кінотеатрів у ТЗ — тут для демо один із трьома залами)
INSERT INTO "Cinemas" ("Id", "Name", "Address", "City", "Phone") VALUES
    ('c0000000-0000-0000-0000-000000000001', 'CineVerse Central', 'вул. Соборна, 10', 'Хмельницький', '+380001112233');

INSERT INTO "Halls" ("Id", "CinemaId", "Name", "Type", "Capacity") VALUES
    ('d0000000-0000-0000-0000-000000000001', 'c0000000-0000-0000-0000-000000000001', 'Зал №1 IMAX', 'IMAX', 120),
    ('d0000000-0000-0000-0000-000000000002', 'c0000000-0000-0000-0000-000000000001', 'Зал №2 Standard', 'STANDARD', 80),
    ('d0000000-0000-0000-0000-000000000003', 'c0000000-0000-0000-0000-000000000001', 'Зал №3 VIP', 'VIP', 40);

-- Генерація місць для Залу №1 IMAX: 10 рядів по 12 місць, ряд 8 і 9 місця 5-6 — Love Seat, ряд 1 — Disabled
DO $$
DECLARE
    r INT;
    s INT;
    seat_type VARCHAR(20);
BEGIN
    FOR r IN 1..10 LOOP
        FOR s IN 1..12 LOOP
            seat_type := 'STANDARD';
            IF r = 1 AND s <= 2 THEN
                seat_type := 'DISABLED';
            ELSIF r >= 8 AND s BETWEEN 5 AND 6 THEN
                seat_type := 'LOVE_SEAT';
            ELSIF r >= 8 THEN
                seat_type := 'VIP';
            END IF;

            INSERT INTO "Seats" ("HallId", "RowNumber", "SeatNumber", "Type")
            VALUES ('d0000000-0000-0000-0000-000000000001', r, s, seat_type);
        END LOOP;
    END LOOP;
END $$;

-- Сеанси
INSERT INTO "Sessions" ("Id", "MovieId", "HallId", "StartTime", "EndTime", "Format", "BasePrice") VALUES
    ('e0000000-0000-0000-0000-000000000001',
     'b0000000-0000-0000-0000-000000000001',
     'd0000000-0000-0000-0000-000000000001',
     (CURRENT_DATE + TIME '19:30:00')::TIMESTAMPTZ,
     (CURRENT_DATE + TIME '19:30:00')::TIMESTAMPTZ + INTERVAL '189 minutes',
     'IMAX', 250.00);

-- Промокоди
INSERT INTO "Promotions" ("Id", "Code", "DiscountType", "DiscountValue", "ExpiresAt", "UsageLimit") VALUES
    ('f0000000-0000-0000-0000-000000000001', 'STUDENT20', 'PERCENT', 20.00, now() + INTERVAL '90 days', 1000),
    ('f0000000-0000-0000-0000-000000000002', 'WELCOME50', 'FIXED', 50.00, now() + INTERVAL '30 days', 500);

-- Адміністратор за замовчуванням (email: admin@cineverse.local / пароль: Admin!2026)
-- Хеш — реальний BCrypt (work factor 11), сумісний і з BCrypt.Net-Next на бекенді.
-- ОБОВ'ЯЗКОВО змініть цей пароль одразу після першого входу в продакшн-середовищі.
INSERT INTO "Users" ("Id", "FirstName", "LastName", "Email", "PasswordHash", "Phone", "Role", "IsEmailConfirmed") VALUES
    ('10000000-0000-0000-0000-000000000001', 'System', 'Admin', 'admin@cineverse.local',
     '$2b$11$.ghnp..YEaxl10G9WJ3zV.90tMD2LBrlQNFLM8mAlNHKlYMMgMrS6', '+380990000000', 'ADMIN', TRUE);

-- Демо-акаунт контролера для тестування кабінету валідації квитків (Етап 7)
-- email: checker@cineverse.local / пароль: Checker!2026
INSERT INTO "Users" ("Id", "FirstName", "LastName", "Email", "PasswordHash", "Phone", "Role", "IsEmailConfirmed") VALUES
    ('10000000-0000-0000-0000-000000000002', 'Іван', 'Контролер', 'checker@cineverse.local',
     '$2b$11$q2L70hWXEkUYVYGcgVpxB.kR6Eh7zbfMLa0zgEDoac4gouqiRSHIS', '+380990000001', 'CHECKER', TRUE);
