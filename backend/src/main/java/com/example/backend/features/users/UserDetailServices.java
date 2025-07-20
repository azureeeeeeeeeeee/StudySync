package com.example.backend.features.users;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserDetailServices implements UserDetailsService {
    private final UserRepository userRepository;

    public UserDetailServices(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Optional<CustomUser> tempUser = userRepository.findByUsername(username);
        if (tempUser.isPresent()) {
            CustomUser user = tempUser.get();
            String role = user.getIsAdmin() ? "ROLE_ADMIN" : "ROLE_USER";
            return User
                    .withUsername(user.getUsername())
                    .password(user.getPassword())
                    .authorities(role)
                    .build();
        }
        throw new UsernameNotFoundException("User not found with given username: " + username);
    }
}
