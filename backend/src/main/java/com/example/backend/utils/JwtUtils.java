package com.test.backend.utils;


import com.example.backend.users.CustomUser;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;

import javax.crypto.SecretKey;
import java.util.Date;
import java.util.Optional;

public class JwtUtils {
    private static final String SECRET_KEY = "yourSecretKeyAndItMustBeLongEnoughForSecurity";

    public static String generateToken(Optional<CustomUser> user) {
        if (user.isPresent()) {
            CustomUser customUser = user.get();
            return Jwts
                    .builder()
                    .subject(customUser.getId() + ":" + customUser.getIsAdmin())
                    .expiration(new Date(System.currentTimeMillis() + 300000))
                    .signWith(getSigningKey())
                    .compact();
        }
        return "User not found";

    }

    public static Claims getClaims(String token){
        return Jwts
                .parser()
                .verifyWith(getSigningKey())
                .build()
                .parseSignedClaims(token)
                .getPayload();
    }

    private static boolean isExpired(String token) {
        return getClaims(token)
                .getExpiration()
                .before(new Date());
    }

    public static boolean isTokenValid(String token){
        return !isExpired(token);
    }

    private static SecretKey getSigningKey() {
        byte[] keyBytes = Decoders.BASE64.decode(SECRET_KEY);
        return Keys.hmacShaKeyFor(keyBytes);
    }
}