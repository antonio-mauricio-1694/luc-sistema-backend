// src/main/java/br/com/lucsistema/contrller/AcessoController.java

package br.com.lucsistema.contrller;


import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import br.com.lucsistema.model.Acesso;
import br.com.lucsistema.service.AcessoService;

@RestController
public class AcessoController {

 private final AcessoService acessoService;

 public AcessoController(AcessoService acessoService) {
     this.acessoService = acessoService;
 }

 @PostMapping("/salvarAcesso")
 public ResponseEntity<Acesso> salvar(@RequestBody Acesso acesso) {
     return ResponseEntity.ok(acessoService.save(acesso));
 }

 @DeleteMapping("/deleteAcesso/{id}")
 public ResponseEntity<String> deletar(@PathVariable Long id) {
     acessoService.deleteAcesso(id); 
     return ResponseEntity.ok("Deletado com sucesso");
 }
}