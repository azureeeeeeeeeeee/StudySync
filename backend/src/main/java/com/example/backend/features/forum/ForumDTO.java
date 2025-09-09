package com.example.backend.features.forum;

import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

public class ForumDTO {
    public Integer id;
    public String title;
    public String description;
    public String owner;
    public List<ForumFileDTO> files;
    
    public ForumDTO(Forum forum) {
        this.id = forum.getId();
        this.title = forum.getTitle();
        this.description = forum.getDescription();
        this.owner = forum.getAddedBy().getUsername();
        this.files = forum.getFiles().stream().map(ForumFileDTO::new).collect(Collectors.toList());
    }
}
