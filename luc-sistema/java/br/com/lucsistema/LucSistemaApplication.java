package br.com.lucsistema;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EntityScan(basePackages = "br.com.lucsistema.model")
@ComponentScan(basePackages = {"br.com.*"})
@EnableJpaRepositories(basePackages = {"br.com.lucsistema.repository"})
@EnableTransactionManagement
public class LucSistemaApplication {

	public static void main(String[] args) {
		SpringApplication.run(LucSistemaApplication.class, args);
	}

}
