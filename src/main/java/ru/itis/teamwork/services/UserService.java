package ru.itis.teamwork.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import ru.itis.teamwork.forms.SignUpForm;
import ru.itis.teamwork.models.Roles;
import ru.itis.teamwork.models.User;
import ru.itis.teamwork.repositories.UserRepository;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {
    private UserRepository userRepository;

    private PasswordEncoder passwordEncoder;

    @Autowired
    public UserService(UserRepository userRepository,
                       PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByUsername(username);
        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }
        return user;
    }

    public Optional<User> getUserById(Long id) {
        return userRepository.findById(id);
    }

    public boolean addUser(SignUpForm userForm) {
        User userFromDb = userRepository.findByUsername(userForm.getUsername());
        if (userFromDb != null) {
            return false;
        }
        userForm.setPassword(passwordEncoder.encode(userForm.getPassword()));
        userForm.setRoles(Collections.singleton(Roles.USER));

        User newUser = new User();
        newUser.setFirstName(userForm.getFirstName());
        newUser.setLastName(userForm.getLastName());
        newUser.setUsername(userForm.getUsername());
        newUser.setPassword(userForm.getPassword());
        newUser.setRoles(userForm.getRoles());

        System.out.println(userForm);

        userRepository.save(newUser);
        return true;
    }

    public List<User> getAllUsers() {
        return (List<User>) userRepository.findAll();
    }

    public void updateInfo(User user) {
        userRepository.save(user);
    }

    public void saveUser(User user, Map<String, String> form) {
        Set<String> roles = Arrays.stream(Roles.values())
                .map(Roles::name)
                .collect(Collectors.toSet());
        user.getRoles().clear();
        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Roles.valueOf(key));
            }
        }
        userRepository.save(user);
    }
}
