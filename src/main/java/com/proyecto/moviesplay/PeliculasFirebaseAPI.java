package com.proyecto.moviesplay;

import java.time.format.SignStyle;
import java.util.List;

public class PeliculasFirebaseAPI {

    private List<Results> results;

    public List<Results> getResults() {
        return results;
    }

    class Results {
        private String id;
        private String title;
        private String original_title;
        private String vote_average;
        private String overview;
        private String poster_path;
        private String trailer;
        private String video;
        private List<Actors> actors;

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

        public String getTrailer() {
            return trailer;
        }

        public String getVideo() {
            return video;
        }

        public List<Actors> getActors() {
            return actors;
        }

        class Actors {
            private String id;
            private String idMovie;
            private String name;
            private String profile_path;

            public String getId() {
                return id;
            }

            public String getIdMovie() {
                return idMovie;
            }

            public String getName() {
                return name;
            }

            public String getProfile_path() {
                return profile_path;
            }
        }
    }

}
