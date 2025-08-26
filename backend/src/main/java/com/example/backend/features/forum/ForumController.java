package com.example.backend.features.forum;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.example.backend.DTO.JsonResponse;

@RestController
public class ForumController {
    private final ForumServices forumServices;

    public ForumController(ForumServices forumServices) {
        this.forumServices = forumServices;
    }

    @PostMapping("/api/forum")
    public ResponseEntity<JsonResponse<Void>> createForum(@RequestBody Forum forum) {
        return forumServices.create(forum);
    }

    @GetMapping("/api/forum")
    public ResponseEntity<JsonResponse<Object>> findAllForum() {
        return forumServices.findAll();
    }

    @GetMapping("/api/forum/{id}")
    public ResponseEntity<JsonResponse<Object>> findOneForum(@PathVariable Integer id) {
        return forumServices.findById(id);
    }
}
