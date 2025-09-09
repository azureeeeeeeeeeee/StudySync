package com.example.backend.features.forum;

import com.example.backend.features.users.CustomUser;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "files")
public class ForumFile {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Integer id;

    @Column(name = "title")
    @NotNull(message = "Files's title is required")
    public String title;

    @Column(name = "url")
    @NotNull(message = "Files's url is required")
    public String url;

    // @Column(name = "")
    @ManyToOne
    @JoinColumn(name = "added_by", nullable = false)
    public CustomUser addedBy;

    @ManyToOne
    @JoinColumn(name = "forum_id", nullable = false)
    public Forum forum;

    public ForumFile() {

    }

    public ForumFile(Integer id, String title, CustomUser user, Forum forum) {
        this.id = id;
        this.title = title;
        this.addedBy = user;
        this.forum = forum;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public CustomUser getAddedBy() {
        return addedBy;
    }

    public void setAddedBy(CustomUser addedBy) {
        this.addedBy = addedBy;
    }

    public Forum getForum() {
        return forum;
    }

    public void setForum(Forum forum) {
        this.forum = forum;
    }
}
