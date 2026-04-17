// src/main/java/br/com/lucsistema/security/WebConfigSecurity.java

package br.com.lucsistema.security;



import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class WebConfigSecurity {

 @Bean
 public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

     http
         .csrf(csrf -> csrf.disable())
         .authorizeHttpRequests(auth -> auth
             .anyRequest().permitAll() 
         );

     return http.build();
 }
}