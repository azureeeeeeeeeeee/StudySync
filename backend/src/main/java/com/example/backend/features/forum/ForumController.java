package com.example.backend.features.forum;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

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

    @PostMapping("/api/forum/{id}/file")
    public ResponseEntity<JsonResponse<Object>> addFileToForum(
        @PathVariable Integer id, 
        @RequestParam("file") MultipartFile file, 
        @RequestParam("title") String title) {
        return forumServices.addResource(id, file, title);
    }

    @DeleteMapping("/api/forum/{idForum}/file/{idFile}")
    public ResponseEntity<JsonResponse<Object>> deleteFileFromForum(@PathVariable Integer idForum, @PathVariable Integer idFile) {
        return forumServices.deleteResource(idForum, idFile);
    }
}
