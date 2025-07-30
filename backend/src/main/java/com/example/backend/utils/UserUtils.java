package com.example.backend.utils;

import com.example.backend.features.users.CustomUser;
import com.example.backend.features.users.UserRepository;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserUtils {
    private final UserRepository userRepository;

    public UserUtils(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public CustomUser getUser() {
        try {
            String subject = SecurityContextHolder.getContext().getAuthentication().getPrincipal().toString();
            String[] parts = subject.split(":");

            if (parts.length != 2) return null;

            Integer userId = Integer.parseInt(parts[0]);
            Optional<CustomUser> user = userRepository.findById(userId);
            return user.orElse(null);
        } catch (NullPointerException | NumberFormatException e) {
            return null;
        }
    }
}
