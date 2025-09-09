package com.example.backend.features.forum;

import com.example.backend.DTO.JsonResponse;
import com.example.backend.features.users.CustomUser;
import com.example.backend.utils.UserUtils;

import java.io.File;
import java.util.List;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class ForumServices {
    private final ForumRepository forumRepository;
    private final UserUtils userUtils;
    private static final String UPLOAD_DIR = System.getProperty("user.dir") + "/uploads";

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


    public ResponseEntity<JsonResponse<Object>> addResource(Integer idForum, MultipartFile file, String title) {
        JsonResponse<Object> response = new JsonResponse<>();

        
        try {
            Optional<Forum> checkForum = forumRepository.findById(idForum);
            if (checkForum.isEmpty()) {
                throw new Exception("Forum tidak ditemukan dengan id " + idForum);
            };

            Forum forum = checkForum.get();
            CustomUser user = userUtils.getUser();
            
            File folder = new File(UPLOAD_DIR);
            if (!folder.exists()) {
                folder.mkdirs();
            }
    
            String filename = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            File dest = new File(folder, filename);

            file.transferTo(dest);

            ForumFile forumFile = new ForumFile();
            forumFile.setAddedBy(user);
            forumFile.setForum(forum);
            forumFile.setTitle(title);
            forumFile.setUrl("/uploads/" + filename);

            forum.addFile(forumFile);
            forumRepository.save(forum);

            response.setMessage("File berhasil ditambahkan");
            return ResponseEntity.status(HttpStatus.OK).body(response);
        } catch (Exception e) {
            response.setMessage("Error : " + e.getMessage());
            response.setData(null);

            return ResponseEntity.status(HttpStatus.OK).body(response);
        }
    }

    public ResponseEntity<JsonResponse<Object>> deleteResource(Integer idForum, Integer fileId) {
        JsonResponse<Object> response = new JsonResponse<>();

        try {
            Optional<Forum> checkForum = forumRepository.findById(idForum);
            if (checkForum.isEmpty()) {
                throw new Exception("Forum tidak ditemukan dengan id " + idForum);
            }

            Forum forum = checkForum.get();

            ForumFile fileToDelete = forum.getFiles()
                    .stream()
                    .filter(f -> f.getId().equals(fileId))
                    .findFirst()
                    .orElseThrow(() -> new Exception("File tidak ditemukan dengan id " + fileId));

            File physicalFile = new File(System.getProperty("user.dir") + fileToDelete.getUrl());
            if (physicalFile.exists()) {
                physicalFile.delete();
            }

            forum.removeFile(fileToDelete);
            forumRepository.save(forum);

            response.setMessage("File berhasil dihapus");
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            response.setMessage("Error : " + e.getMessage());
            response.setData(null);
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
    }
}
