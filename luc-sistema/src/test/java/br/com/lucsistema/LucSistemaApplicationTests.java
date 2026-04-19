// src/test/java/br/com/lucsistema/LucSistemaApplicationTests.java
package br.com.lucsistema;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import br.com.lucsistema.contrller.AcessoController;
import br.com.lucsistema.model.Acesso;
import br.com.lucsistema.repository.AcessoRepository;
import br.com.lucsistema.service.AcessoService;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

@SpringBootTest
@Transactional
class LucSistemaApplicationTests {

    @Autowired
    private AcessoService acessoService;
    
    @Autowired
    private AcessoRepository acessoRepository;
    
    @Autowired
    private AcessoController acessoController;

    @Test
    void testeCadastraAcesso() {
        Acesso acesso = new Acesso();
        acesso.setDescricao("ROLE_ADMIN");
        
        assertEquals(true, acesso.getId() == null);

        Acesso salvo = acessoService.save(acesso);

        assertNotNull(salvo.getId(), "ID não deve ser nulo após persistência");
        assertEquals("ROLE_ADMIN", salvo.getDescricao(), "Descrição deve ser preservada");

        System.out.println("ID SALVO: " + salvo.getId());
        
        //GRAVOU NO BANCO DE DADOS
        assertEquals(true, acesso.getId() > 0);
        
        //VALIDA OS DADOS DA FORMA CORRETA 
        assertEquals("ROLE_ADMIN", acesso.getDescricao());
        
        
        // TESTE DE CAREGAMENTO
        
       Acesso acesso2  = acessoRepository.findById(acesso.getId()).get();
       
       assertEquals(acesso.getId(), acesso2.getId());
       
       // TESTE DE DELETE
       
       acessoRepository.deleteById(acesso.getId());
       
       acessoRepository.flush();// RODA O SQL NO BANCO 
       
      // Acesso acesso3 = acessoRepository.findById(acesso2.getId()).orElse(null);
        
      // assertEquals(true, acesso3.getId() == null);
       
       
       //TESTE DE QUERY
       
       Acesso acesso3 = new Acesso();
       
       acesso3.setDescricao("ROLE_ALUNO");
       
       acesso3 = acessoController.salvar(acesso3).getBody();
       
       List<Acesso> acessos = acessoRepository.buscarAcessoPorDescricao("ALUNO".trim().toUpperCase());
       assertEquals(1,acessos.size());
       
       acessoRepository.deleteById(acesso3.getId());
       
        
    }
}