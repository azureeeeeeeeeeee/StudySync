CREATE TABLE forums (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    added_by INT NOT NULL,

    CONSTRAINT fk_forum_added_by FOREIGN KEY (added_by) REFERENCES users(id) ON DELETE CASCADE
)