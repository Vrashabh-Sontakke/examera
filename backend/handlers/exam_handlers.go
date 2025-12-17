package handlers

import (
	"database/sql"
	"encoding/json"
	"net/http"
)

type Exam struct {
	ID                  int             `json:"id"`
	Title               string          `json:"title"`
	Description         string          `json:"description"`
	ExamDate            string          `json:"exam_date"`
	ApplicationDeadline string          `json:"application_deadline"`
	ApplicationLink     string          `json:"application_link"`
	OfficialWebsite     string          `json:"official_website"`
	SyllabusLink        string          `json:"syllabus_link"`
	Eligibility         string          `json:"eligibility"`
	Fee                 json.RawMessage `json:"fee"`
	Status              string          `json:"status"`
}

func GetExamsHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		rows, err := db.Query("SELECT id, title, description, exam_date, application_deadline, status FROM exams ORDER BY exam_date ASC")
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		defer rows.Close()

		var exams []Exam
		for rows.Next() {
			var e Exam
			err := rows.Scan(&e.ID, &e.Title, &e.Description, &e.ExamDate, &e.ApplicationDeadline, &e.Status)
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}
			exams = append(exams, e)
		}

		json.NewEncoder(w).Encode(exams)
	}
}
