import { useState } from "react";
import { Link } from "react-router-dom";
import type { MovieListItem } from "@/types";
import { toYoutubeEmbedUrl } from "@/utils/youtube";

/** Афішна картка фільму: постер домінує, мінімум чрому — без рамок/тіней у стилі типової SaaS-картки.
 *  Кнопка "▶" поверх постера дозволяє переглянути трейлер прямо в афіші, без переходу на сторінку фільму. */
export default function MovieCard({ movie }: { movie: MovieListItem }) {
  const [trailerOpen, setTrailerOpen] = useState(false);
  const embedUrl = toYoutubeEmbedUrl(movie.trailerUrl);

  return (
    <div className="group block w-40 shrink-0 sm:w-48">
      <div className="relative aspect-[2/3] overflow-hidden rounded-sm bg-charcoal-800">
        {trailerOpen && embedUrl ? (
          <div className="absolute inset-0 z-10 bg-charcoal-950">
            <button
              type="button"
              onClick={(e) => {
                e.preventDefault();
                setTrailerOpen(false);
              }}
              className="absolute right-1.5 top-1.5 z-20 flex h-6 w-6 items-center justify-center rounded-full bg-charcoal-950/80 text-ink hover:bg-accent"
              aria-label="Закрити трейлер"
            >
              ×
            </button>
            <iframe
              src={`${embedUrl}?autoplay=1`}
              title={`Трейлер: ${movie.title}`}
              className="h-full w-full"
              allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
              allowFullScreen
            />
          </div>
        ) : (
          <Link to={`/movies/${movie.id}`} className="block h-full w-full">
            {movie.posterUrl ? (
              <img
                src={movie.posterUrl}
                alt={movie.title}
                className="h-full w-full object-cover transition-transform duration-300 group-hover:scale-105"
                onError={(e) => (e.currentTarget.style.display = "none")}
              />
            ) : (
              <div className="flex h-full items-center justify-center text-ink-muted">Немає постера</div>
            )}
          </Link>
        )}

        {!trailerOpen && movie.status === "NOW_SHOWING" && (
          <span className="absolute left-2 top-2 rounded-sm bg-marquee px-2 py-0.5 text-xs font-semibold text-charcoal-950">
            У прокаті
          </span>
        )}

        {!trailerOpen && embedUrl && (
          <button
            type="button"
            onClick={(e) => {
              e.preventDefault();
              setTrailerOpen(true);
            }}
            className="absolute bottom-2 right-2 flex h-8 w-8 items-center justify-center rounded-full bg-charcoal-950/80 text-ink transition-colors hover:bg-accent"
            aria-label={`Трейлер: ${movie.title}`}
            title="Дивитись трейлер"
          >
            ▶
          </button>
        )}
      </div>
      <Link to={`/movies/${movie.id}`}>
        <h3 className="mt-2 line-clamp-1 text-sm font-medium text-ink group-hover:text-accent transition-colors">
          {movie.title}
        </h3>
        <p className="text-xs text-ink-muted">{movie.genres.slice(0, 2).join(", ") || movie.ageRating}</p>
      </Link>
    </div>
  );
}
