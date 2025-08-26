package com.example.backend.features.forum;

import com.example.backend.DTO.JsonResponse;
import com.example.backend.features.users.CustomUser;
import com.example.backend.utils.UserUtils;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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

        try {
            forum.setAddedBy(user);
            forumRepository.save(forum);
    
            response.setMessage("Forum added successfully");
            return ResponseEntity.status(HttpStatus.OK).body(response);
        } catch (Exception e) {
            response.setMessage(e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
    }

    public ResponseEntity<JsonResponse<Object>> findAll() {
        JsonResponse<Object> response = new JsonResponse<>();

        List<Forum> forums = forumRepository.findAll();
        List<ForumDTO> forumDTOs = forums.stream().map(ForumDTO::new).toList();

        response.setMessage("All forums fetched");
        response.setData(forumDTOs);

        return ResponseEntity.status(HttpStatus.OK).body(response);
    }


    public ResponseEntity<JsonResponse<Object>> findById(Integer id) {
        JsonResponse<Object> response = new JsonResponse<>();

        try {
            Forum forum = forumRepository.findById(id).get();
            ForumDTO forumDTO = new ForumDTO(forum);
            response.setMessage("Forum fetched");
            response.setData(forumDTO);
        } catch (Exception e) {
            response.setMessage("Error : " + e.getMessage());
            response.setData(null);
        }

        return ResponseEntity.status(HttpStatus.OK).body(response);
    }

}
