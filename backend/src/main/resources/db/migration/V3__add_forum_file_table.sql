CREATE TABLE files (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    url TEXT NOT NULL,
    added_by INT NOT NULL,
    forum_id INT NOT NULL,

    CONSTRAINT fk_file_added_by FOREIGN KEY (added_by) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT fk_file_forum_id FOREIGN KEY (forum_id) REFERENCES forums(id) ON DELETE CASCADE
)