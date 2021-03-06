package ru.itis.teamwork.models;

import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "user_main_img")
@Data
public class UserMainImg {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", unique = true, nullable = false)
    private Long id;

    @Column(name = "original_name", nullable = false)
    private String originalName;

    @Column(name = "hash_name", nullable = false, unique = true)
    private String hashName;

    @Column(name = "type", nullable = false)
    private String type;

    @OneToOne(mappedBy = "img")
    private User user;

    public String getFullName() {
        return hashName + "." + type;
    }
}
