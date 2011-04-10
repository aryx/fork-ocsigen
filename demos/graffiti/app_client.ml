open XHTML5.M
  
open Shared
  
open Client
  
(* the service is available fo 10 seconds only, but it is long
	 enouth for the browser to do its request. *)
let _ =
  Eliommod_cli.register_closure (Int64.to_int 569575520L)
    (fun
       (__eliom__escaped_expr__reserved_name__1,
        __eliom__escaped_expr__reserved_name__2,
        __eliom__escaped_expr__reserved_name__3)
       ->
       launch_client_canvas
         (Eliom_client_bus.unwrap __eliom__escaped_expr__reserved_name__1)
         (Eliommod_cli.unwrap __eliom__escaped_expr__reserved_name__2)
         (Eliommod_cli.unwrap_node __eliom__escaped_expr__reserved_name__3))
  

