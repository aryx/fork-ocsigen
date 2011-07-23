module H = HTML5.M

(*****************************************************************************)
(* Main entry point *)
(*****************************************************************************)
let main_service =
  Server.App.register_service ~path:[""] ~get_params:Eliom_parameters.unit
  (fun () () ->
    Eliom_services.onload
      {{ Client.launch_client_canvas %Server.bus %Server.imageservice }};
    Lwt.return
      (H.html
	  (H.head
	    (H.title (H.pcdata "Graffiti"))
 	    [ H.link ~rel:[ `Stylesheet ] 
                ~href:(H.uri_of_string"css/app.css")();
              H.link ~rel:[ `Stylesheet ]
                ~href:(H.uri_of_string"css/closure/common.css")();
              H.link ~rel:[ `Stylesheet ]
                ~href:(H.uri_of_string"css/closure/hsvpalette.css")();
              H.link ~rel:[ `Stylesheet ]
                ~href:(H.uri_of_string"css/slider.css")();
              H.unique
                (H.script
                    ~a:[H.a_src (H.uri_of_string "app_oclosure.js")]
                    (H.pcdata ""))
            ])
	  (H.body []))
  )
