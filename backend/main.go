package main

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
	"github.com/rs/cors"
	"github.com/user/examera-backend/handlers"
)

func main() {
	// Database connection string
	connStr := os.Getenv("DATABASE_URL")
	if connStr == "" {
		connStr = "postgres://examera:examera_pass@localhost:5432/examera_db?sslmode=disable"
	}

	db, err := sql.Open("postgres", connStr)
	if err != nil {
		log.Fatal(err)
	}
	defer db.Close()

	if err := db.Ping(); err != nil {
		log.Printf("Warning: Could not connect to database: %v", err)
	} else {
		log.Println("Successfully connected to database")
	}

	r := mux.NewRouter()

	// Auth routes
	r.HandleFunc("/register", handlers.RegisterHandler(db)).Methods("POST")
	r.HandleFunc("/login", handlers.LoginHandler(db)).Methods("POST")

	// Exam routes
	r.HandleFunc("/exams", handlers.GetExamsHandler(db)).Methods("GET")

	// Tracking routes
	r.HandleFunc("/track", handlers.TrackExamHandler(db)).Methods("POST")

	// Health check
	r.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		fmt.Fprintf(w, "OK")
	}).Methods("GET")

	// CORS wrapper
	c := cors.New(cors.Options{
		AllowedOrigins:   []string{"*"}, // Be more restrictive in production
		AllowedMethods:   []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowedHeaders:   []string{"Authorization", "Content-Type"},
		AllowCredentials: true,
	})

	handler := c.Handler(r)

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	log.Printf("Server starting on port %s", port)
	log.Fatal(http.ListenAndServe(":"+port, handler))
}
