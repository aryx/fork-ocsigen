module H = XHTML5.M
  
module App =
  Eliom_output.Eliom_appl
    (struct
       (* must be the name of the .js file *)
       let application_name = "client"
         
       let params = Eliom_output.default_appl_params
         
     end)
  
let main_service =
  App.register_service ~path: [ "" ] ~get_params: Eliom_parameters.unit
    (fun () () -> Lwt.return [ H.h1 [ H.pcdata "Graffiti" ] ])
  

