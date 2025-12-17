package handlers

import (
	"database/sql"
	"encoding/json"
	"net/http"

	"github.com/user/examera-backend/auth"
)

type User struct {
	ID           int    `json:"id"`
	Email        string `json:"email"`
	Password     string `json:"password,omitempty"`
	FullName     string `json:"full_name"`
	IsSubscribed bool   `json:"is_subscribed"`
}

func RegisterHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var user User
		err := json.NewDecoder(r.Body).Decode(&user)
		if err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
			return
		}

		hashedPassword, err := auth.HashPassword(user.Password)
		if err != nil {
			http.Error(w, "Error hashing password", http.StatusInternalServerError)
			return
		}

		err = db.QueryRow(
			"INSERT INTO users (email, password_hash, full_name) VALUES ($1, $2, $3) RETURNING id",
			user.Email, hashedPassword, user.FullName,
		).Scan(&user.ID)

		if err != nil {
			http.Error(w, "User already exists or database error", http.StatusConflict)
			return
		}

		user.Password = ""
		w.WriteHeader(http.StatusCreated)
		json.NewEncoder(w).Encode(user)
	}
}

func LoginHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		var credentials struct {
			Email    string `json:"email"`
			Password string `json:"password"`
		}
		err := json.NewDecoder(r.Body).Decode(&credentials)
		if err != nil {
			http.Error(w, err.Error(), http.StatusBadRequest)
			return
		}

		var id int
		var passwordHash string
		err = db.QueryRow("SELECT id, password_hash FROM users WHERE email = $1", credentials.Email).Scan(&id, &passwordHash)
		if err != nil {
			http.Error(w, "Invalid email or password", http.StatusUnauthorized)
			return
		}

		if !auth.CheckPasswordHash(credentials.Password, passwordHash) {
			http.Error(w, "Invalid email or password", http.StatusUnauthorized)
			return
		}

		token, err := auth.GenerateJWT(id)
		if err != nil {
			http.Error(w, "Error generating token", http.StatusInternalServerError)
			return
		}

		json.NewEncoder(w).Encode(map[string]string{"token": token})
	}
}
