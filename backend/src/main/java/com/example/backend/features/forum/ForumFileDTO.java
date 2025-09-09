package com.example.backend.features.forum;

public class ForumFileDTO {
    public Integer id;
    public String title;
    public String url;

    public ForumFileDTO(ForumFile file) {
        this.id = file.getId();
        this.title = file.getTitle();
        this.url = file.getUrl();
    }
}
