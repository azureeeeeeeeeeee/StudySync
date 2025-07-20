package com.example.backend.features.users;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "users")
public class CustomUser {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public Integer id;

    @Column(name = "username", nullable = false, unique = true)
    public String username;

    @Column(name = "password", nullable = false)
    public String password;

    @Column(name = "isAdmin", nullable = false)
    @JsonProperty("is_admin")
    public boolean isAdmin;

    @Column(name = "created_at", updatable = false)
    public LocalDateTime createdAt;

    public CustomUser(Integer id, LocalDateTime createdAt, boolean isAdmin, String password, String username) {
        this.id = id;
        this.createdAt = createdAt;
        this.isAdmin = isAdmin;
        this.password = password;
        this.username = username;
    }

    public CustomUser() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(boolean admin) {
        isAdmin = admin;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
