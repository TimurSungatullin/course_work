package ru.itis.teamwork.models;

import ru.itis.teamwork.models.CompositeKey.ProjectCommandKey;

import javax.persistence.*;

@Entity
@Table(name = "project_command")
public class ProjectCommand {

    @EmbeddedId
    private ProjectCommandKey id;

    @ManyToOne
    @MapsId("project_id")
    @JoinColumn(name = "project_id")
    private Project project;

    @ManyToOne
    @MapsId("user_id")
    @JoinColumn(name = "user_id")
    private SiteUser user;

    @Column(name = "team_lead")
    private Boolean teamLead;
}