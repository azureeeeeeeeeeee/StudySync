package com.example.backend.features.forum;

public class ForumDTO {
    public Integer id;
    public String title;
    public String description;
    public String owner;
    
    public ForumDTO(Forum forum) {
        this.id = forum.getId();
        this.title = forum.getTitle();
        this.description = forum.getDescription();
        this.owner = forum.getAddedBy().getUsername();
    }
}
