package com.proyecto.moviesplay;

import java.util.List;

public class PeliculasAPI {

    private List<ResultsP> results;

    public List<ResultsP> getResultsP() {
        return results;
    }

    class ResultsP {
        private String id;
        private String title;
        private String original_title;
        private String vote_average;
        private String overview;
        private String poster_path;

        public String getId() {
            return id;
        }

        public String getTitle() {
            return title;
        }

        public String getOriginal_title() {
            return original_title;
        }

        public String getVote_average() {
            return vote_average;
        }

        public String getOverview() {
            return overview;
        }

        public String getPoster_path() {
            return poster_path;
        }
    }
}
