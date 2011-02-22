(* example from dario teixeira pgocaml tutorial *)

let create_table dbh = 
  PGSQL(dbh) "execute" 
  "create temporary table test_users
  ( 
  id  serial not null primary key,
  name  text not null,
  age  int not null
  )"
let insert_user dbh name age = 
  PGSQL(dbh) "INSERT INTO test_users (name, age)
             VALUES ($name, $age)"

let get_users dbh = 
   PGSQL(dbh) "SELECT id, name, age FROM test_users"

let print_user (id, name, age) = 
  Printf.printf "Id: %ld Name: %s Age: %ld \n" id name age

let _ = 
  let dbh = PGOCaml.connect () in
  let () = 
    try create_table dbh 
    with exn -> 
      Printf.printf "error when creating table\n";
  in
  let () = 
    insert_user dbh "John" (Int32.of_int 301);
    insert_user dbh "Mary" (Int32.of_int 401);
    insert_user dbh "Mark" (Int32.of_int 421)
  in
  List.iter print_user (get_users dbh)

(* to test:
 * $ ./project
 * Id: 1 Name: John Age: 301 
 * Id: 2 Name: Mary Age: 401 
 * Id: 3 Name: Mark Age: 421 
 * 
 * TODO: how to manually inspect the database ?
 *)
