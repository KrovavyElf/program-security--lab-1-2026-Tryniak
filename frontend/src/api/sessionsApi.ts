import { httpClient } from "./httpClient";
import type { SessionListItem } from "@/types";

export const sessionsApi = {
  getSessions: (params: { movieId?: string; cinemaId?: string; date?: string }) =>
    httpClient.get<SessionListItem[]>("/sessions", { params }).then((r) => r.data),
  createSession: (data: unknown) => httpClient.post("/sessions", data),
  // Той самий фікс, що й у moviesApi.updateMovie: UpdateSessionCommand звіряє SessionId з тіла
  // запиту з Id з маршруту й повертав 400, бо sessionId у тілі не передавався.
  updateSession: (id: string, data: unknown) =>
    httpClient.put(`/sessions/${id}`, { sessionId: id, ...(data as object) }),
  deleteSession: (id: string) => httpClient.delete(`/sessions/${id}`)
};
