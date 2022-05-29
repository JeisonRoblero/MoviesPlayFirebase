package com.proyecto.moviesplay;

import java.util.List;

public class ActoresAPI {

    private String id;
    private List<Cast> cast;

    public String getId() {
        return id;
    }

    public List<Cast> getCast() {
        return cast;
    }

    class Cast {
        private String id;
        private String name;
        private String profile_path;

        public String getId() {
            return id;
        }

        public String getName() {
            return name;
        }

        public String getProfile_path() {
            return profile_path;
        }
    }
}
