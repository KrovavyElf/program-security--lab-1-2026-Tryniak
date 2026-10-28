-- ============================================================================
-- CineVerse — відгуки з підтвердженою покупкою, сеанси на вихідні
-- та заповнення залів реальними бронюваннями (30–90% від місткості).
-- Виконується автоматично після 001->002->003->004 на чистому томі.
-- Якщо том вже існує — застосуйте вручну (README, "Усунення несправностей").
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 1. 100 нових користувачів-клієнтів — пул для відгуків і бронювань нижче.
-- ---------------------------------------------------------------------------
-- Пароль для ВСІХ облікових записів нижче: Customer!2026 (той самий реальний
-- BCrypt-хеш, що вже використовувався в 004_full_network_seed.sql).
INSERT INTO "Users" ("Id", "FirstName", "LastName", "Email", "PasswordHash", "Phone", "Role", "IsEmailConfirmed") VALUES
    ('30000000-0000-0000-0000-000000000001', 'Максим', 'Сидоренко', 'maksym.sydorenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000001', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000002', 'Ігор', 'Мельник', 'ihor.melnyk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000002', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000003', 'Денис', 'Лисенко', 'denys.lysenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000003', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000004', 'Андрій', 'Пасічник', 'andrii.pasichnyk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000004', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000005', 'Роман', 'Бойко', 'roman.boiko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000005', 'CUSTOMER', FALSE),
    ('30000000-0000-0000-0000-000000000006', 'Марина', 'Кравченко', 'maryna.kravchenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000006', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000007', 'Іван', 'Ткаченко', 'ivan.tkachenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000007', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000008', 'Олег', 'Савчук', 'oleh.savchuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000008', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000009', 'Інна', 'Мороз', 'inna.moroz@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000009', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000010', 'Оксана', 'Кучер', 'oksana.kucher@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000010', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000011', 'Марина', 'Кравченко', 'maryna.kravchenko2@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000011', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000012', 'Ігор', 'Гаврилюк', 'ihor.havryliuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000012', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000013', 'Павло', 'Кучер', 'pavlo.kucher@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000013', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000014', 'Соломія', 'Пасічник', 'solomiia.pasichnyk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000014', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000015', 'Артем', 'Захарчук', 'artem.zakharchuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000015', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000016', 'Андрій', 'Бойко', 'andrii.boiko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000016', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000017', 'Руслан', 'Савчук', 'ruslan.savchuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000017', 'CUSTOMER', FALSE),
    ('30000000-0000-0000-0000-000000000018', 'Костянтин', 'Олійник', 'kostiantyn.oliinyk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000018', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000019', 'Софія', 'Захарчук', 'sofiia.zakharchuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000019', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000020', 'Марина', 'Литвин', 'maryna.lytvyn@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000020', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000021', 'Тарас', 'Демченко', 'taras.demchenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000021', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000022', 'Григорій', 'Гончарук', 'hryhorii.honcharuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000022', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000023', 'Людмила', 'Іщенко', 'liudmyla.ishchenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000023', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000024', 'Дарина', 'Бондаренко', 'daryna.bondarenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000024', 'CUSTOMER', FALSE),
    ('30000000-0000-0000-0000-000000000025', 'Євген', 'Бойко', 'ievhen.boiko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000025', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000026', 'Богдан', 'Гнатюк', 'bohdan.hnatiuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000026', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000027', 'Артем', 'Шевченко', 'artem.shevchenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000027', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000028', 'Тарас', 'Гнатюк', 'taras.hnatiuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000028', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000029', 'Катерина', 'Клименко', 'kateryna.klymenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000029', 'CUSTOMER', FALSE),
    ('30000000-0000-0000-0000-000000000030', 'Аліна', 'Ткачук', 'alina.tkachuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000030', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000031', 'Іван', 'Ткачук', 'ivan.tkachuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000031', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000032', 'Юлія', 'Марченко', 'iuliia.marchenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000032', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000033', 'Ігор', 'Кучер', 'ihor.kucher@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000033', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000034', 'Максим', 'Онищенко', 'maksym.onyshchenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000034', 'CUSTOMER', FALSE),
    ('30000000-0000-0000-0000-000000000035', 'Уляна', 'Кравченко', 'uliana.kravchenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000035', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000036', 'Богдана', 'Юрчук', 'bohdana.iurchuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000036', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000037', 'Сергій', 'Демченко', 'serhii.demchenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000037', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000038', 'Андрій', 'Лисенко', 'andrii.lysenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000038', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000039', 'Євген', 'Кравченко', 'ievhen.kravchenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000039', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000040', 'Інна', 'Мельник', 'inna.melnyk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000040', 'CUSTOMER', FALSE),
    ('30000000-0000-0000-0000-000000000041', 'Марія', 'Лисенко', 'mariia.lysenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000041', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000042', 'Тарас', 'Дзюба', 'taras.dziuba@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000042', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000043', 'Сергій', 'Мазур', 'serhii.mazur@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000043', 'CUSTOMER', FALSE),
    ('30000000-0000-0000-0000-000000000044', 'Артем', 'Гончарук', 'artem.honcharuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000044', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000045', 'Руслан', 'Марченко', 'ruslan.marchenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000045', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000046', 'Світлана', 'Бондаренко', 'svitlana.bondarenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000046', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000047', 'Дарина', 'Савчук', 'daryna.savchuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000047', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000048', 'Зоряна', 'Бабенко', 'zoriana.babenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000048', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000049', 'Марія', 'Марченко', 'mariia.marchenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000049', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000050', 'Дарина', 'Ткачук', 'daryna.tkachuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000050', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000051', 'Софія', 'Ткачук', 'sofiia.tkachuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000051', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000052', 'Зоряна', 'Гриценко', 'zoriana.hrytsenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000052', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000053', 'Уляна', 'Ткачук', 'uliana.tkachuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000053', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000054', 'Григорій', 'Бондаренко', 'hryhorii.bondarenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000054', 'CUSTOMER', FALSE),
    ('30000000-0000-0000-0000-000000000055', 'Валентина', 'Марченко', 'valentyna.marchenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000055', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000056', 'Дарина', 'Кузьменко', 'daryna.kuzmenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000056', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000057', 'Дарина', 'Кучер', 'daryna.kucher@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000057', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000058', 'Артем', 'Гриценко', 'artem.hrytsenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000058', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000059', 'Євген', 'Коваленко', 'ievhen.kovalenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000059', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000060', 'Настасія', 'Шевченко', 'nastasiia.shevchenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000060', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000061', 'Юрій', 'Гриценко', 'iurii.hrytsenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000061', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000062', 'Назар', 'Захарчук', 'nazar.zakharchuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000062', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000063', 'Уляна', 'Сидоренко', 'uliana.sydorenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000063', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000064', 'Марія', 'Поліщук', 'mariia.polishchuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000064', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000065', 'Максим', 'Стельмах', 'maksym.stelmakh@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000065', 'CUSTOMER', FALSE),
    ('30000000-0000-0000-0000-000000000066', 'Тетяна', 'Гордієнко', 'tetiana.hordiienko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000066', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000067', 'Богдана', 'Дзюба', 'bohdana.dziuba@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000067', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000068', 'Олена', 'Коваленко', 'olena.kovalenko2@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000068', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000069', 'Наталія', 'Бабенко', 'nataliia.babenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000069', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000070', 'Микола', 'Лисенко', 'mykola.lysenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000070', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000071', 'Денис', 'Пасічник', 'denys.pasichnyk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000071', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000072', 'Ігор', 'Клименко', 'ihor.klymenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000072', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000073', 'Григорій', 'Дзюба', 'hryhorii.dziuba@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000073', 'CUSTOMER', FALSE),
    ('30000000-0000-0000-0000-000000000074', 'Світлана', 'Клименко', 'svitlana.klymenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000074', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000075', 'Тетяна', 'Малий', 'tetiana.malyi@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000075', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000076', 'Людмила', 'Мороз', 'liudmyla.moroz@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000076', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000077', 'Тетяна', 'Мороз', 'tetiana.moroz@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000077', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000078', 'Наталія', 'Юрчук', 'nataliia.iurchuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000078', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000079', 'Світлана', 'Юрчук', 'svitlana.iurchuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000079', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000080', 'Інна', 'Кравченко', 'inna.kravchenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000080', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000081', 'Станіслав', 'Мельник', 'stanislav.melnyk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000081', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000082', 'Зоряна', 'Олійник', 'zoriana.oliinyk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000082', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000083', 'Світлана', 'Осадчук', 'svitlana.osadchuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000083', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000084', 'Людмила', 'Онищенко', 'liudmyla.onyshchenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000084', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000085', 'Іван', 'Бабенко', 'ivan.babenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000085', 'CUSTOMER', FALSE),
    ('30000000-0000-0000-0000-000000000086', 'Катерина', 'Юрчук', 'kateryna.iurchuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000086', 'CUSTOMER', FALSE),
    ('30000000-0000-0000-0000-000000000087', 'Павло', 'Гнатюк', 'pavlo.hnatiuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000087', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000088', 'Руслан', 'Олійник', 'ruslan.oliinyk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000088', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000089', 'Микола', 'Гончарук', 'mykola.honcharuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000089', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000090', 'Тетяна', 'Кучер', 'tetiana.kucher@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000090', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000091', 'Людмила', 'Ткачук', 'liudmyla.tkachuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000091', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000092', 'Артем', 'Поліщук', 'artem.polishchuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000092', 'CUSTOMER', FALSE),
    ('30000000-0000-0000-0000-000000000093', 'Юлія', 'Гаврилюк', 'iuliia.havryliuk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000093', 'CUSTOMER', FALSE),
    ('30000000-0000-0000-0000-000000000094', 'Олег', 'Гриценко', 'oleh.hrytsenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000094', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000095', 'Віталій', 'Бондаренко', 'vitalii.bondarenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000095', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000096', 'Валентин', 'Бондаренко', 'valentyn.bondarenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000096', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000097', 'Ірина', 'Онищенко', 'iryna.onyshchenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000097', 'CUSTOMER', FALSE),
    ('30000000-0000-0000-0000-000000000098', 'Іван', 'Мельник', 'ivan.melnyk@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000098', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000099', 'Станіслав', 'Мороз', 'stanislav.moroz@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000099', 'CUSTOMER', TRUE),
    ('30000000-0000-0000-0000-000000000100', 'Олег', 'Марченко', 'oleh.marchenko@example.com', '$2b$11$247n8Sa9QViuTilzSP6sn.BoZn42XaqtLNqW3w9hyJcta/KgalBAu', '+380501000100', 'CUSTOMER', TRUE);

-- ---------------------------------------------------------------------------
-- 2. Сеанси на вихідні (Сб/Нд) — раніше генерувались лише робочі дні.
-- ---------------------------------------------------------------------------
-- Той самий алгоритм, що й у 004_full_network_seed.sql: для кожного з 30 залів
-- на кожен вихідний день у 2-місячному вікні сеанси йдуть впритул з 10:00
-- до 22:00 з перервою 30 хв між фільмами. Ротація фільмів зсунута (+100 до
-- day_idx), щоб вихідний розклад не був точною копією найближчого буднього дня
-- в тому самому залі.
DO $$
DECLARE
    hall_rec       RECORD;
    movie_ids      UUID[];
    movie_durations INT[];
    movie_count    INT;
    session_format VARCHAR(20);
    session_price  DECIMAL(10,2);
    hall_idx       INT := 0;
    cur_date       DATE;
    end_date       DATE;
    day_idx        INT;
    slot_idx       INT;
    cursor_time    TIMESTAMPTZ;
    day_end        TIMESTAMPTZ;
    mv_pos         INT;
    mv_id          UUID;
    mv_duration    INT;
    sess_end       TIMESTAMPTZ;
BEGIN
    SELECT array_agg("Id" ORDER BY "Title"), array_agg("Duration" ORDER BY "Title")
      INTO movie_ids, movie_durations
      FROM "Movies"
      WHERE "Status" = 'NOW_SHOWING';
    movie_count := array_length(movie_ids, 1);

    end_date := CURRENT_DATE + INTERVAL '2 months';

    FOR hall_rec IN SELECT "Id", "Type" FROM "Halls" ORDER BY "Id" LOOP
        hall_idx := hall_idx + 1;

        session_format := CASE hall_rec."Type"
            WHEN 'IMAX'    THEN 'IMAX'
            WHEN 'VIP'     THEN 'VIP'
            WHEN 'FOUR_DX' THEN '4DX'
            WHEN 'THREE_D' THEN '3D'
            ELSE '2D'
        END;
        session_price := CASE hall_rec."Type"
            WHEN 'IMAX'    THEN 280.00  -- вихідний тариф трохи вищий за буднього дня
            WHEN 'VIP'     THEN 390.00
            WHEN 'FOUR_DX' THEN 330.00
            WHEN 'THREE_D' THEN 260.00
            ELSE 190.00
        END;

        day_idx  := 100; -- зсув ротації відносно 004, щоб не дублювати буднішній патерн 1:1
        cur_date := CURRENT_DATE;
        WHILE cur_date < end_date LOOP
            -- ISODOW: Сб=6, Нд=7
            IF EXTRACT(ISODOW FROM cur_date) IN (6, 7) THEN
                cursor_time := cur_date + TIME '10:00';
                day_end     := cur_date + TIME '22:00';
                slot_idx    := 0;

                LOOP
                    mv_pos      := ((hall_idx + day_idx + slot_idx) % movie_count) + 1;
                    mv_id       := movie_ids[mv_pos];
                    mv_duration := movie_durations[mv_pos];
                    sess_end    := cursor_time + (mv_duration || ' minutes')::INTERVAL;

                    EXIT WHEN sess_end > day_end;

                    INSERT INTO "Sessions" ("MovieId", "HallId", "StartTime", "EndTime", "Format", "BasePrice")
                    VALUES (mv_id, hall_rec."Id", cursor_time, sess_end, session_format, session_price);

                    cursor_time := sess_end + INTERVAL '30 minutes';
                    slot_idx    := slot_idx + 1;
                END LOOP;

                day_idx := day_idx + 1;
            END IF;

            cur_date := cur_date + INTERVAL '1 day';
        END LOOP;
    END LOOP;
END $$;

-- ---------------------------------------------------------------------------
-- 3. Відгуки на фільми, що йдуть у прокаті (3–7 різних відгуків на фільм).
-- ---------------------------------------------------------------------------
INSERT INTO "Reviews" ("Id", "UserId", "MovieId", "Rating", "Comment", "IsVerified") VALUES
    -- Інтерстеллар (b...0001) — 6 відгуків
    ('40000000-0000-0000-0000-000000000001', '30000000-0000-0000-0000-000000000001', 'b0000000-0000-0000-0000-000000000001', 5, 'Ностальгія накрила ще на титрах. Дочекався повторного прокату в IMAX — і не пошкодував, картинка на великому екрані зовсім інша.', FALSE),
    ('40000000-0000-0000-0000-000000000002', '30000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000001', 5, 'Пересивав вже вкотре, і кожен раз щось відчуваю на моменті з посланнями від дітей. Ханс Циммер — геній.', FALSE),
    ('40000000-0000-0000-0000-000000000003', '30000000-0000-0000-0000-000000000003', 'b0000000-0000-0000-0000-000000000001', 4, 'Наукова частина подана дуже доступно, хоча місцями сюжет розтягнутий. Візуально — шедевр.', FALSE),
    ('40000000-0000-0000-0000-000000000004', '30000000-0000-0000-0000-000000000004', 'b0000000-0000-0000-0000-000000000001', 5, 'Найкращий фантастичний фільм десятиліття. Звук у залі був просто вражаючий.', FALSE),
    ('40000000-0000-0000-0000-000000000005', '30000000-0000-0000-0000-000000000005', 'b0000000-0000-0000-0000-000000000001', 3, 'Гарна картинка, але друга половина фільму трохи затягнута. Очікував динамічніше.', FALSE),
    ('40000000-0000-0000-0000-000000000006', '30000000-0000-0000-0000-000000000006', 'b0000000-0000-0000-0000-000000000001', 5, 'Взяв з собою батька, який фізик — каже, навіть наукова частина зроблена коректно. Рекомендую всім.', FALSE),
    -- Оппенгеймер (b...0002) — 5 відгуків
    ('40000000-0000-0000-0000-000000000007', '30000000-0000-0000-0000-000000000007', 'b0000000-0000-0000-0000-000000000002', 5, 'Кіліан Мерфі вивозить увесь фільм на собі. Три години пролетіли непомітно.', FALSE),
    ('40000000-0000-0000-0000-000000000008', '30000000-0000-0000-0000-000000000008', 'b0000000-0000-0000-0000-000000000002', 4, 'Дуже щільний монтаж, місцями важко встигати за таймлайном, але загалом сильна робота Нолана.', FALSE),
    ('40000000-0000-0000-0000-000000000009', '30000000-0000-0000-0000-000000000009', 'b0000000-0000-0000-0000-000000000002', 5, 'Історична драма, від якої мурашки. Звукорежисура окремо заслуговує на нагороду.', FALSE),
    ('40000000-0000-0000-0000-000000000010', '30000000-0000-0000-0000-000000000010', 'b0000000-0000-0000-0000-000000000002', 3, 'Затягнуто як на мене, особливо суд у другій половині. Акторська гра рятує.', FALSE),
    ('40000000-0000-0000-0000-000000000011', '30000000-0000-0000-0000-000000000011', 'b0000000-0000-0000-0000-000000000002', 5, 'Один із небагатьох фільмів, після якого хочеться почитати книгу-першоджерело.', FALSE),
    -- Одіссея (b...0007) — 5 відгуків
    ('40000000-0000-0000-0000-000000000012', '30000000-0000-0000-0000-000000000012', 'b0000000-0000-0000-0000-000000000007', 5, 'Нолан знову здивував — знято дуже масштабно, локації вражають.', FALSE),
    ('40000000-0000-0000-0000-000000000013', '30000000-0000-0000-0000-000000000013', 'b0000000-0000-0000-0000-000000000007', 4, 'Гарна адаптація міфу, хоча дехто з акторів здався тут не на своєму місці.', FALSE),
    ('40000000-0000-0000-0000-000000000014', '30000000-0000-0000-0000-000000000014', 'b0000000-0000-0000-0000-000000000007', 5, 'IMAX-плівка це щось особливе, картинка неймовірно чітка навіть на дальніх планах.', FALSE),
    ('40000000-0000-0000-0000-000000000015', '30000000-0000-0000-0000-000000000015', 'b0000000-0000-0000-0000-000000000007', 4, 'Динамічно, красиво, місцями надто щільно для тих, хто не знайомий з першоджерелом.', FALSE),
    ('40000000-0000-0000-0000-000000000016', '30000000-0000-0000-0000-000000000016', 'b0000000-0000-0000-0000-000000000007', 2, 'Чекав більшої драми характерів, а отримав радше пригодницький бойовик. Не найгірше, але не моє.', FALSE),
    -- Людина-павук: Абсолютно новий день (b...0004) — 4 відгуки
    ('40000000-0000-0000-0000-000000000017', '30000000-0000-0000-0000-000000000017', 'b0000000-0000-0000-0000-000000000004', 4, 'Легкий, динамічний, з гарним гумором — саме те, що очікуєш від нового Павука.', FALSE),
    ('40000000-0000-0000-0000-000000000018', '30000000-0000-0000-0000-000000000018', 'b0000000-0000-0000-0000-000000000004', 5, 'Найкраща частина після повернення в кіновсесвіт! Екшн-сцени поставлені бездоганно.', FALSE),
    ('40000000-0000-0000-0000-000000000019', '30000000-0000-0000-0000-000000000019', 'b0000000-0000-0000-0000-000000000004', 3, 'Непогано, але відчувається, що це радше перехідний фільм перед чимось більшим.', FALSE),
    ('40000000-0000-0000-0000-000000000020', '30000000-0000-0000-0000-000000000020', 'b0000000-0000-0000-0000-000000000004', 4, 'Водив дітей — у захваті всі троє. Попкорн-муві на всі сто.', FALSE),
    -- Шрек, повторний прокат (b...0005) — 6 відгуків
    ('40000000-0000-0000-0000-000000000021', '30000000-0000-0000-0000-000000000021', 'b0000000-0000-0000-0000-000000000005', 5, 'Дитинство в кінотеатрі — це було неймовірно! Зала сміялась разом з дітьми.', FALSE),
    ('40000000-0000-0000-0000-000000000022', '30000000-0000-0000-0000-000000000022', 'b0000000-0000-0000-0000-000000000005', 5, 'Класика, яка не старіє. Приємно було подивитись на великому екрані знову.', FALSE),
    ('40000000-0000-0000-0000-000000000023', '30000000-0000-0000-0000-000000000023', 'b0000000-0000-0000-0000-000000000005', 4, 'Українська озвучка так само чудова, як і 20 років тому.', FALSE),
    ('40000000-0000-0000-0000-000000000024', '30000000-0000-0000-0000-000000000024', 'b0000000-0000-0000-0000-000000000005', 5, 'Взяла всю сім''ю, навіть бабуся сміялась. Дякую за повторний прокат!', FALSE),
    ('40000000-0000-0000-0000-000000000025', '30000000-0000-0000-0000-000000000025', 'b0000000-0000-0000-0000-000000000005', 3, 'Гарна ностальгія, хоча деякі жарти вже не такі смішні, як у дитинстві.', FALSE),
    ('40000000-0000-0000-0000-000000000026', '30000000-0000-0000-0000-000000000026', 'b0000000-0000-0000-0000-000000000005', 5, 'Ідеальний варіант для походу в кіно з дітьми у вихідний.', FALSE),
    -- Форсаж, репрайз (b...0008) — 4 відгуки
    ('40000000-0000-0000-0000-000000000027', '30000000-0000-0000-0000-000000000027', 'b0000000-0000-0000-0000-000000000008', 4, 'Пригадав молодість — гонки виглядають наївно на фоні сучасних частин, але атмосфера топ.', FALSE),
    ('40000000-0000-0000-0000-000000000028', '30000000-0000-0000-0000-000000000028', 'b0000000-0000-0000-0000-000000000008', 5, 'Оригінал завжди найкращий. Пол Вокер — легенда.', FALSE),
    ('40000000-0000-0000-0000-000000000029', '30000000-0000-0000-0000-000000000029', 'b0000000-0000-0000-0000-000000000008', 3, 'Цікаво було подивитись, з чого все починалось, хоча темп подекуди повільний.', FALSE),
    ('40000000-0000-0000-0000-000000000030', '30000000-0000-0000-0000-000000000030', 'b0000000-0000-0000-0000-000000000008', 4, 'Ідеальна ретро-подорож у 2001-й. Приємний повторний прокат.', FALSE),
    -- Заколот (b...0006) — 3 відгуки
    ('40000000-0000-0000-0000-000000000031', '30000000-0000-0000-0000-000000000031', 'b0000000-0000-0000-0000-000000000006', 4, 'Стейтем не підводить, динамічний бойовик без зайвих претензій.', FALSE),
    ('40000000-0000-0000-0000-000000000032', '30000000-0000-0000-0000-000000000032', 'b0000000-0000-0000-0000-000000000006', 3, 'Непогано для одноразового перегляду, сюжет доволі передбачуваний.', FALSE),
    ('40000000-0000-0000-0000-000000000033', '30000000-0000-0000-0000-000000000033', 'b0000000-0000-0000-0000-000000000006', 5, 'Найкращий бойовик Стейтема за останні роки, тримає в напрузі до фіналу.', FALSE);

-- ---------------------------------------------------------------------------
-- 4. "Підтверджені" відгуки: кожен автор відгуку реально купує квиток на той
--    фільм, який оцінює (Review.IsVerified -> TRUE), а не просто лишає коментар.
-- ---------------------------------------------------------------------------
DO $$
DECLARE
    rev_rec       RECORD;
    picked_session RECORD;
    seats_to_buy  INT;
    seat_rec      RECORD;
    new_booking_id UUID;
    total_price   DECIMAL(10,2);
    ticket_status VARCHAR(20);
    booking_status VARCHAR(20);
    seq_counter   BIGINT := 0;
BEGIN
    FOR rev_rec IN
        SELECT "Id" AS review_id, "UserId" AS user_id, "MovieId" AS movie_id
        FROM "Reviews"
        WHERE "Id"::text LIKE '40000000-%'
    LOOP
        -- Один із перших 6 хронологічних сеансів цього фільму (у різних залах) —
        -- щоб "підтверджені покупки" не концентрувались усі в одному зі
        -- 30 залів мережі.
        SELECT s."Id" AS session_id, s."HallId" AS hall_id, s."BasePrice" AS base_price, s."EndTime" AS end_time
          INTO picked_session
          FROM "Sessions" s
          WHERE s."MovieId" = rev_rec.movie_id
          ORDER BY s."StartTime", random()
          LIMIT 1 OFFSET floor(random() * 6)::INT;

        IF picked_session.session_id IS NULL THEN
            CONTINUE; -- на випадок, якщо для фільму раптом немає жодного сеансу
        END IF;

        seats_to_buy := 1 + floor(random() * 2)::INT; -- 1 або 2 квитки на автора відгуку
        total_price := 0;
        booking_status := 'CONFIRMED';
        ticket_status := CASE WHEN picked_session.end_time < now() THEN 'USED' ELSE 'ACTIVE' END;

        INSERT INTO "Bookings" ("UserId", "SessionId", "Status", "TotalPrice", "ExpiresAt")
        VALUES (rev_rec.user_id, picked_session.session_id, booking_status, 0, now() + INTERVAL '1 year')
        RETURNING "Id" INTO new_booking_id;

        FOR seat_rec IN
            SELECT se."Id" AS seat_id
              FROM "Seats" se
              WHERE se."HallId" = picked_session.hall_id
                AND se."Type" <> 'DISABLED'
                AND NOT EXISTS (
                    SELECT 1 FROM "Tickets" t
                    WHERE t."SessionId" = picked_session.session_id AND t."SeatId" = se."Id"
                )
              ORDER BY random()
              LIMIT seats_to_buy
        LOOP
            seq_counter := seq_counter + 1;
            INSERT INTO "BookingSeats" ("BookingId", "SeatId", "Price")
            VALUES (new_booking_id, seat_rec.seat_id, picked_session.base_price);

            INSERT INTO "Tickets" ("BookingId", "SessionId", "SeatId", "TicketCode", "QrCode", "Status")
            VALUES (
                new_booking_id, picked_session.session_id, seat_rec.seat_id,
                'CV-RV-' || to_char(seq_counter, 'FM000000') || '-' || substr(md5(random()::text), 1, 6),
                '', ticket_status
            );

            total_price := total_price + picked_session.base_price;
        END LOOP;

        UPDATE "Bookings" SET "TotalPrice" = total_price WHERE "Id" = new_booking_id;

        INSERT INTO "Payments" ("BookingId", "Amount", "Method", "Status", "TransactionId")
        VALUES (
            new_booking_id, total_price,
            (ARRAY['CARD', 'ONLINE'])[1 + floor(random() * 2)::INT],
            'SUCCESS',
            'REVIEW-PURCHASE-' || substr(md5(new_booking_id::text), 1, 12)
        );

        UPDATE "Reviews" SET "IsVerified" = TRUE WHERE "Id" = rev_rec.review_id;
    END LOOP;
END $$;

-- ---------------------------------------------------------------------------
-- 5. Заповнення залів реальними бронюваннями (30–90% місткості на сеанс).
-- ---------------------------------------------------------------------------
-- Масштаб: у мережі 30 залів і ~7500+ сеансів на 2 місяці наперед; продати
-- 30-90% КОЖНОГО з них наперед по всьому горизонту нереалістично навіть для
-- демо-даних (сотні тисяч рядків) і не відповідає тому, як насправді працює
-- бронювання (квитки розкуповують ближче до дати сеансу). Тому "живе"
-- заповнення генерується для сеансів на найближчі 3 дні (сьогодні +
-- 2 наступні, включно з новододаними вихідними) в УСІХ 30 залах мережі —
-- це та частина розкладу, яку користувач реально побачить як "майже
-- розкуплено" одразу після запуску. Сеанси далі в майбутньому свідомо
-- лишаються вільними, як і має бути.
DO $$
DECLARE
    filler_users   UUID[];
    users_count    INT;
    sess_rec       RECORD;
    target_seats   INT;
    sold_so_far    INT;
    group_size     INT;
    seat_ids       UUID[];
    picked_user    UUID;
    new_booking_id UUID;
    total_price    DECIMAL(10,2);
    seat_id        UUID;
    ticket_status  VARCHAR(20);
    seq_counter    BIGINT := 0;
BEGIN
    SELECT array_agg("Id") INTO filler_users FROM "Users" WHERE "Id"::text LIKE '30000000-%';
    users_count := array_length(filler_users, 1);

    FOR sess_rec IN
        SELECT s."Id" AS session_id, s."HallId" AS hall_id, s."BasePrice" AS base_price,
               s."EndTime" AS end_time, h."Capacity" AS capacity
          FROM "Sessions" s
          JOIN "Halls" h ON h."Id" = s."HallId"
          WHERE s."StartTime" >= CURRENT_DATE
            AND s."StartTime" < CURRENT_DATE + INTERVAL '3 days'
    LOOP
        target_seats := GREATEST(1, ROUND(sess_rec.capacity * (0.30 + random() * 0.60))::INT);

        -- скільки місць у цьому сеансі вже продано (напр., з блоку "підтверджені відгуки")
        SELECT count(*) INTO sold_so_far FROM "Tickets" WHERE "SessionId" = sess_rec.session_id;

        -- перемішаний список ще вільних місць залу для цього сеансу
        SELECT array_agg(se."Id" ORDER BY random())
          INTO seat_ids
          FROM "Seats" se
          WHERE se."HallId" = sess_rec.hall_id
            AND NOT EXISTS (
                SELECT 1 FROM "Tickets" t
                WHERE t."SessionId" = sess_rec.session_id AND t."SeatId" = se."Id"
            );

        ticket_status := CASE WHEN sess_rec.end_time < now() THEN 'USED' ELSE 'ACTIVE' END;

        WHILE sold_so_far < target_seats AND array_length(seat_ids, 1) > 0 LOOP
            group_size := LEAST(
                1 + floor(random() * 3)::INT,           -- 1-3 місця на одне бронювання (компанія друзів)
                target_seats - sold_so_far,
                array_length(seat_ids, 1)
            );
            picked_user := filler_users[1 + floor(random() * users_count)::INT];
            total_price := 0;

            INSERT INTO "Bookings" ("UserId", "SessionId", "Status", "TotalPrice", "ExpiresAt")
            VALUES (picked_user, sess_rec.session_id, 'CONFIRMED', 0, now() + INTERVAL '1 year')
            RETURNING "Id" INTO new_booking_id;

            FOR i IN 1..group_size LOOP
                seat_id := seat_ids[array_length(seat_ids, 1)];
                seat_ids := seat_ids[1:array_length(seat_ids, 1) - 1]; -- знімаємо останній елемент масиву
                seq_counter := seq_counter + 1;

                INSERT INTO "BookingSeats" ("BookingId", "SeatId", "Price")
                VALUES (new_booking_id, seat_id, sess_rec.base_price);

                INSERT INTO "Tickets" ("BookingId", "SessionId", "SeatId", "TicketCode", "QrCode", "Status")
                VALUES (
                    new_booking_id, sess_rec.session_id, seat_id,
                    'CV-' || to_char(seq_counter, 'FM0000000') || '-' || substr(md5(random()::text), 1, 6),
                    '', ticket_status
                );

                total_price := total_price + sess_rec.base_price;
            END LOOP;

            UPDATE "Bookings" SET "TotalPrice" = total_price WHERE "Id" = new_booking_id;

            INSERT INTO "Payments" ("BookingId", "Amount", "Method", "Status", "TransactionId")
            VALUES (
                new_booking_id, total_price,
                (ARRAY['CARD', 'CASH', 'ONLINE'])[1 + floor(random() * 3)::INT],
                'SUCCESS',
                'FILL-' || substr(md5(new_booking_id::text), 1, 12)
            );

            sold_so_far := sold_so_far + group_size;
        END LOOP;
    END LOOP;
END $$;
