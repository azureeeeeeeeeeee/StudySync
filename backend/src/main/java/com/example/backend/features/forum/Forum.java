package com.example.backend.features.forum;

import java.util.ArrayList;
import java.util.List;

import com.example.backend.features.users.CustomUser;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "forums")
public class Forum {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Integer id;

    @Column(name = "title")
    @NotNull(message = "Forum's title is required")
    public String title;

    @Column(name = "description")
    @NotNull(message = "Forum's description is required")
    public String description;

    @ManyToOne
    @JoinColumn(name = "added_by")
    public CustomUser addedBy;

    @OneToMany(mappedBy = "forum", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<ForumFile> files = new ArrayList<>();

    public Forum(Integer id, String title, CustomUser addedBy, String description) {
        this.id = id;
        this.title = title;
        this.addedBy = addedBy;
        this.description = description;
    }

    public Forum() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public CustomUser getAddedBy() {
        return addedBy;
    }
 
    public void setAddedBy(CustomUser addedBy) {
        this.addedBy = addedBy;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List<ForumFile> getFiles() {
        return this.files;
    }

    public void addFile(ForumFile file) {
        files.add(file);
        file.setForum(this);
    }

    public void removeFile(ForumFile file) {
        files.remove(file);
        file.setForum(null);
    }
}
