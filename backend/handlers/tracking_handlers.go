package handlers

import (
	"database/sql"
	"encoding/json"
	"net/http"
)

func TrackExamHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var trackInfo struct {
			UserID int    `json:"user_id"`
			ExamID int    `json:"exam_id"`
			Status string `json:"status"` // applied, attempted, etc.
		}
		err := json.NewDecoder(r.Body).Decode(&trackInfo)
		if err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
			return
		}

		_, err = db.Exec(
			"INSERT INTO user_exams (user_id, exam_id, tracking_status) VALUES ($1, $2, $3) ON CONFLICT (user_id, exam_id) DO UPDATE SET tracking_status = $3",
			trackInfo.UserID, trackInfo.ExamID, trackInfo.Status,
		)

		if err != nil {
			http.Error(w, "Error updating tracking status", http.StatusInternalServerError)
			return
		}

		w.WriteHeader(http.StatusOK)
		json.NewEncoder(w).Encode(map[string]string{"status": "success"})
	}
}
