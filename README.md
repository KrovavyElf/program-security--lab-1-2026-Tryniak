# CineVerse — Вебсервіс Онлайн-Кінотеатру

**Лабораторна робота №1 з дисципліни «Безпека програмного забезпечення»**  
**Тема:** Розгортання нового проєкту. Організаційна підготовка. Створення документації та структури проєкту.

---

## 📋 Короткий опис проєкту

**CineVerse** — це сучасна платформа для перегляду розкладу сеансів, вибору та онлайн-бронювання місць у кінотеатрі в режимі реального часу, купівлі квитків, а також їх перевірки контролерами за допомогою QR-кодів.

---

## 📐 Використані стандарти та методології

При організації репозиторію, архітектури та супровідної документації враховано вимоги міжнародних стандартів:

* **ISO/IEC/IEEE 12207:2026** — Процеси життєвого циклу програмного забезпечення (ітеративна розробка та супровід).
* **ISO/IEC/IEEE 15289:2019** — Вимоги до змісту та структури інформаційних елементів (документації) життєвого циклу.
* **ISO/IEC/IEEE 29148:2018** — Інженерія вимог (формулювання специфікацій та функціональних вимог).
* **ISO/IEC/IEEE 42010:2022** — Опис архітектури програмного забезпечення (Clean Architecture, мультисервісна взаємодія).
* **NIST SP 800-218 (SSDF)** — Рамкова модель безпечної розробки (інтеграція заходів безпеки, захист від конкурентних запитів та протермінованих бронювань).

---

## 📁 Структура проєкту

Репозиторій впорядковано згідно з рекомендаціями стандартів щодо розділення вихідного коду, конфігурацій, тестів та документації:

```text
cineverse/
├── backend/                  # REST API на .NET (Clean Architecture)
│   ├── src/
│   │   ├── CineVerse.Domain/          # Сутності, переліки, базова логіка
│   │   ├── CineVerse.Application/     # CQRS (MediatR), сценарії використання, валідація
│   │   ├── CineVerse.Infrastructure/  # EF Core, PostgreSQL, SignalR, Redis, Auth
│   │   └── CineVerse.WebApi/          # Контролери, Middleware, Swagger
│   └── tests/                         # Unit- та Integration-тести
├── frontend/                 # Клієнтська частина на React / Vite / TailwindCSS
│   ├── src/                           # Компоненти, сторінки, API-клієнти, Redux
│   └── public/                        # Статичні ресурси
├── database/                 # SQL-скрипти схеми та початкового наповнення (Seed)
├── docs/                     # Проєктна документація
│   ├── specification/                 # Вимоги та специфікації (ISO 29148)
│   ├── architecture/                  # Опис архітектури системи (ISO 42010)
│   ├── policies/                      # Політики коду та стратегія гілкування Git
│   ├── security/                      # Документація заходів безпеки (NIST SSDF)
│   └── testing/                       # Стратегія тестування
├── nginx/                    # Конфігурації вебсервера та reverse proxy
├── tests/                    # Навантажувальні тести (k6 / race conditions)
├── docker-compose.yml        # Контейнеризація всього стеку
└── README.md                 # Головний опис проєкту
```

---

## 🛠 Технологічний стек

* **Backend:** C# / .NET 8, ASP.NET Core Web API, Entity Framework Core, MediatR, SignalR (Real-time оновлення статусу місць).
* **Database & Caching:** PostgreSQL, Redis (для блокировок місць під час вибору).
* **Frontend:** React, TypeScript, Redux Toolkit, TailwindCSS, Vite.
* **DevOps & Testing:** Docker, Docker Compose, Nginx, xUnit, FluentAssertions, k6.

---

## 🚀 Інструкція із запуску проєкту

### 1. Запуск через Docker Compose (Рекомендований спосіб)

Для швидкого розгортання всього стеку (Backend + Frontend + PostgreSQL + Redis + Nginx):

```bash
# Клонувати репозиторій за допомогою SSH
git clone ssh://git@github.com:<ваш_логін>/program-security--lab-1-2026-<ім'я>.git

cd program-security--lab-1-2026-<ім'я>

# Запустити контейнери
docker-compose up --build -d
```

Після запуску сервіси будуть доступні за адресами:
* **Frontend:** `http://localhost:3000` (або `http://localhost:80`)
* **Backend API / Swagger:** `http://localhost:5000/swagger`

---

### 2. Локальний запуск для розробки

#### Налаштування бази даних та Redis:
Запустіть тільки БД та Redis у Docker:
```bash
docker-compose up -d db redis
```

#### Запуск Backend:
```bash
cd backend/src/CineVerse.WebApi
dotnet restore
dotnet run
```

#### Запуск Frontend:
```bash
cd frontend
npm install
npm run dev
```

---

## 🧪 Запуск тестів

```bash
# Запуск юніт- та інтеграційних тестів
cd backend
dotnet test

# Запуск навантажувальних тестів (перевірка Race Condition при бронюванні)
k6 run tests/load/booking-race-condition.js
```

---

## 📄 Документація

Детальний опис функціоналу, архітектурних рішень та політик розробки розміщено у каталозі [`/docs`](./docs/).