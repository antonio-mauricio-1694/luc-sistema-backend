SELECT constraint_name
FROM information_schema.constraint_column_usage
WHERE table_name = 'usuarios_acesso'
  AND column_name = 'acesso_id'
  AND constraint_name <> 'unique_acesso_user';

  
  alter table usuarios_acesso drop CONSTRAINT "ukdoimqmjqv7fcf54tau3bq14xk"