open XHTML5.M
  
let width = 700
  
let height = 400
  
module My_appl =
  Eliom_output.Eliom_appl
    (struct
       let application_name = "client"
         
       let params = Eliom_output.default_appl_params
         
     end)
  
let main_service =
  My_appl.register_service ~path: [ "" ] ~get_params: Eliom_parameters.unit
    (fun () () ->
       (Eliom_services.onload
          ("caml_run_from_table(569575520, '" ^
             ((Eliom_client_types.jsmarshal ()) ^ "')"));
        Lwt.return [ h1 [ pcdata "Graffiti" ] ]))
  

