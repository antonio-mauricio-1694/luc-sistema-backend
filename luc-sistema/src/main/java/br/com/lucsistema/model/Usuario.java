package br.com.lucsistema.model;

import java.util.Collection;
import java.util.Date;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import jakarta.persistence.ConstraintMode;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.ForeignKey;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.OneToMany;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;
import jakarta.persistence.Temporal;
import jakarta.persistence.TemporalType;
import jakarta.persistence.UniqueConstraint;

@Entity
@Table(name = "usuario")
@SequenceGenerator(name = "seq_usuario", sequenceName = "seq_usuario", allocationSize = 1, initialValue = 1)
public class Usuario implements UserDetails {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_usuario")
	private Long id;

	private String login;
	private String senha;
	
	@Temporal(TemporalType.DATE)
	private Date dataSenhaAtual;
	
	
	
	@OneToMany(fetch = FetchType.LAZY)
	@JoinTable(name="usurios_acesso", uniqueConstraints = @UniqueConstraint(columnNames = {"usurio_id","acesso_id"} ,
	name="unique_acesso_user"),
	joinColumns = @JoinColumn(name= "usuario_id", referencedColumnName = "id", table = "usuario", 
	unique= false , foreignKey = @ForeignKey(name="usuario_fk" , value = ConstraintMode.CONSTRAINT)), 
	inverseJoinColumns = @JoinColumn(name="acesso_id", unique = false , referencedColumnName = "id", table = "acesso",
	foreignKey = @ForeignKey(name= "scesso_fk" , value = ConstraintMode.CONSTRAINT)))
	private List<Acesso> acessos;
	
	
	/* aqui sao Autoridades  que sao os Acessos que e  EX: ROLE_ADMIN, ROLE_FINACEIRO*/

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		
		return this.acessos;
	}

	@Override
	public String getPassword() {
		
		return this.senha;
	}

	@Override
	public String getUsername() {
		
		return this.login;
	}

}
