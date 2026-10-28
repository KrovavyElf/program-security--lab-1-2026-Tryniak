import { httpClient } from "./httpClient";
import type { MovieDetails, MovieListItem, PagedResult } from "@/types";

export const moviesApi = {
  getMovies: (params: { status?: string; genreId?: string; search?: string; pageNumber?: number; pageSize?: number }) =>
    httpClient.get<PagedResult<MovieListItem>>("/movies", { params }).then((r) => r.data),

  getMovieById: (id: string) => httpClient.get<MovieDetails>(`/movies/${id}`).then((r) => r.data),

  createMovie: (data: unknown) => httpClient.post("/movies", data),
  // ВАЖЛИВО: бекенд звіряє Id з маршруту з MovieId у тілі запиту (UpdateMovieCommand) і повертає
  // 400, якщо вони не збігаються. Без movieId у тілі це поле біндиться в Guid.Empty — саме тому
  // редагування фільму не працювало. Той самий фікс застосовано в sessionsApi.updateSession
  // і вже був у cinemasApi.updateHall.
  updateMovie: (id: string, data: unknown) =>
    httpClient.put(`/movies/${id}`, { movieId: id, ...(data as object) }),
  deleteMovie: (id: string) => httpClient.delete(`/movies/${id}`)
};
