package com.example.backend.features.users;

import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserRepository extends JpaRepository<CustomUser, Integer> {
    Optional<CustomUser> findByUsername(String username);
}
