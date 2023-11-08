# ZenHR JobBoard Backend API


## Overview

This repository contains the backend code for a Job Board API. The API is designed to serve as the backend for a job board application, allowing users to list job posts, apply for jobs, and manage job applications. 

## Features

- **User Authentication**: Users can register and login with their email and password. 
- **Role-based Access Control**: Admin users have additional privileges to manage job posts and view job applications, while job seekers have limited access.
- **Job Posts**: Admin users can create, update, and delete job posts, while job seekers can view job listings.
- **Job Applications**: Job seekers can apply for jobs, and admin users can view and manage applications.

## Technologies Used

- **Ruby (v3.2.2)**: The programming language used for development.
- **Ruby on Rails (v7.1.1)**: A web application framework written in Ruby.
- **Sprockets Rails**: The original asset pipeline for Rails.
- **SQLite3 (v1.4)**: The database used for Active Record.
- **Puma (v5.0)**: The web server used for development.
- **JWT (JSON Web Tokens)**: Used for secure authentication and data exchange.
- **Mailtrap**: Used for email testing and debugging in development.
- **CanCanCan**: Used for authorization management.
- **RSwag, RSwag Specs, Swagger Blocks, RSpec API Documentation, Swagger UI**: Used for generating


## Installation

1. Clone the repository.
2. Install required gems using `bundle install`.
3. Set up the database using `rails db:create db:migrate`.
4. Seed the database with test data using `rails db:seed`.

## Usage

- Start the Rails server using `rails s`.
- Use API endpoints to interact with the application (e.g., Postman).

## Testing

- Run RSpec tests using `rspec`.

## API Endpoints

### Job Posts

- `GET /job_posts`: List all job posts.
- `GET /job_posts/:id`: Show details of a specific job post.
- `POST /job_posts`: Create a new job post (Admin only).
- `PUT /job_posts/:id`: Update a job post (Admin only).

### Job Applications

- `GET /job_applications`: List all job applications.
- `GET /job_applications/:id`: Show details of a specific job application.
- `POST /job_applications`: Apply for a job.
- `PUT /job_applications/:id`: Update a job application.

### Authentication

- `POST /auth/login`: User login with email and password.

## Additional Notes

- **Admin Credentials**:
  - Email: admin@gmail.com
  - Password: password

- **Job Seeker Credentials**:
  - Email: jobseeker1@example.com
  - Password: password

- This project uses CanCanCan for authorization and authentication with JSON Web Tokens (JWT).

