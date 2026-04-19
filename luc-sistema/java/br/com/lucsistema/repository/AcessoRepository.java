package br.com.lucsistema.repository;




import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import br.com.lucsistema.model.Acesso;

@Repository
@Transactional
public interface AcessoRepository extends JpaRepository<Acesso, Long>{
	
	
	@Query("SELECT a FROM Acesso a WHERE UPPER(TRIM(a.descricao)) LIKE CONCAT('%', UPPER(:descricao), '%')")
	List<Acesso> buscarAcessoPorDescricao(@Param("descricao") String descricao);

}
