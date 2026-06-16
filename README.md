# Netflix Movies and TV Shows Data Analysis using SQL

## 📌 Project Overview
This project uses SQL to analyze Netflix's movies and TV shows data. The main goal is to explore the data, answer important business questions, and find interesting trends about the content. This README shows the project objectives, the SQL queries used, and the final results of the analysis.


## 📊 Dataset
The project utilizes the `netflix_dataset.csv` file, which contains comprehensive metadata for 8,807 titles available on Netflix. It includes 12 key features such as `show_id`, `type` (Movie/TV Show), `title`, `director`, `cast`, `country`, `date_added`, `release_year`, `rating`, `duration`, `listed_in` (genres), and `description`.

Dataset Link: <a href="https://www.kaggle.com/datasets/shivamb/netflix-shows" target="_blank">Movies Dataset</a>




## 🛠️ Database Setup & Schema

To begin the analysis, the dataset was imported into an SQL database. The following SQL script was used to drop any existing table, create the structured `netflix` table with appropriate data types, and verify the data import:

```sql
-- Drop the table if it already exists
DROP TABLE IF EXISTS netflix;

-- Create the table structure
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    ty           VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);

-- Verify the data import
SELECT * FROM netflix;
