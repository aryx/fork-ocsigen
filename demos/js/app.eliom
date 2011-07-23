module H = HTML5.M

module App = Eliom_output.Eliom_appl (struct
  (* must be the name of the .js file *)
  let application_name = "app"
end)

{client{
  let _ = Dom_html.window##alert(Js.string "Hello")
}}

let main_service =
  App.register_service ~path:[""] ~get_params:Eliom_parameters.unit
    (fun () () -> Lwt.return
      (H.html
          (H.head 
	      (H.title (H.pcdata "Demo"))
              []
          )
          (H.body [
            H.h1 [H.pcdata "Graffiti"]
          ])
      )
    )
