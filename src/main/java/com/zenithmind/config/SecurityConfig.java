package com.zenithmind.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.security.provisioning.UserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

        @Autowired
        private AuthenticationSuccessHandler authenticationSuccessHandler;

        @Bean
        public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
                http
                                .authorizeRequests()
                                .antMatchers("/admin/**").hasRole("ADMIN")
                                .antMatchers("/login", "/register", "/css/**", "/js/**").permitAll()
                                .anyRequest().authenticated()
                                .and()
                                .formLogin()
                                .loginPage("/login")
                                .successHandler(authenticationSuccessHandler)
                                .permitAll()
                                .and()
                                .logout()
                                .permitAll();
                return http.build();
        }

        // Removed local H2 dataSource bean to use the MySQL one from HibernateConfig

        @Bean
        public UserDetailsManager users(DataSource dataSource) {
                UserDetails student = User.withDefaultPasswordEncoder()
                                .username("student")
                                .password("student")
                                .roles("USER")
                                .build();
                UserDetails admin = User.withDefaultPasswordEncoder()
                                .username("admin")
                                .password("admin")
                                .roles("USER", "ADMIN")
                                .build();
                UserDetails faculty = User.withDefaultPasswordEncoder()
                                .username("faculty")
                                .password("faculty")
                                .roles("USER", "FACULTY")
                                .build();
                UserDetails counselor = User.withDefaultPasswordEncoder()
                                .username("counselor")
                                .password("counselor")
                                .roles("USER", "PROFESSIONAL")
                                .build();

                JdbcUserDetailsManager users = new JdbcUserDetailsManager(dataSource);
                if (!users.userExists(student.getUsername()))
                        users.createUser(student);
                if (!users.userExists(admin.getUsername()))
                        users.createUser(admin);
                if (!users.userExists(faculty.getUsername()))
                        users.createUser(faculty);
                if (!users.userExists(counselor.getUsername()))
                        users.createUser(counselor);
                return users;
        }
}
