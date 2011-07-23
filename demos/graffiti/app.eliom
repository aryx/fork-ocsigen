
module H = HTML5.M

let main_service =
  Server.My_appl.register_service ~path:[""] ~get_params:Eliom_parameters.unit
  (fun () () ->
    Eliom_services.onload
      {{
        let (bus:Shared.messages Eliom_bus.t) = %Server.bus in
        
        Client.launch_client_canvas 
          bus %Server.imageservice 
      }};

    Lwt.return
      (H.html
	  (H.head
	    (H.title (H.pcdata "Graffiti"))
 	    [ H.link ~rel:[ `Stylesheet ] 
                ~href:(H.uri_of_string"./css/app.css")();
              H.link ~rel:[ `Stylesheet ]
                ~href:(H.uri_of_string"./css/closure/common.css")();
              H.link ~rel:[ `Stylesheet ]
                ~href:(H.uri_of_string"./css/closure/hsvpalette.css")();
              H.link ~rel:[ `Stylesheet ]
                ~href:(H.uri_of_string"./css/slider.css")();
              Server.oclosure_script;
            ])
	  (H.body []))
  )
