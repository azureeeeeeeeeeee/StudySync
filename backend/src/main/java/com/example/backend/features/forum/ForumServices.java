package com.example.backend.features.forum;

import com.example.backend.DTO.JsonResponse;
import com.example.backend.features.users.CustomUser;
import com.example.backend.utils.UserUtils;
import org.apache.coyote.Response;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;

@Service
public class ForumServices {
    private final ForumRepository forumRepository;
    private final UserUtils userUtils;

    public ForumServices(ForumRepository forumRepository, UserUtils userUtils) {
        this.forumRepository = forumRepository;
        this.userUtils = userUtils;
    }

    public ResponseEntity<JsonResponse<Void>> create(Forum forum) {
        CustomUser user = userUtils.getUser();
        JsonResponse<Void> response = new JsonResponse<>();

        forum.setAddedBy(user);
        forumRepository.save(forum);

        response.setMessage("Forum added successfully");

        return ResponseEntity.status(HttpStatus.OK).body(response);
    }
}
