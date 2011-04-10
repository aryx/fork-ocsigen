open XHTML5.M
  
open Shared
  
open Server
  
let include_canvas (name : string)
                   (canvas_box : [ | Xhtml5types.div ] XHTML5.M.elt) =
  let (bus, image_string) = get_bus_image name in
  let imageservice =
    Eliom_output.Text.register_coservice' ~timeout: 10.
      (* the service is available fo 10 seconds only, but it is long
	 enouth for the browser to do its request. *)
      ~get_params: Eliom_parameters.unit
      (fun () () -> Lwt.return ((image_string ()), "image/png"))
  in
    Eliom_services.onload
      ("caml_run_from_table(569575520, '" ^
         ((Eliom_client_types.jsmarshal
             ((Eliom_bus.wrap bus), (Eliom_services.wrap imageservice),
              (Eliommod_cli.wrap_node canvas_box)))
            ^ "')"))
  
let () =
  My_appl.register ~service: multigraffiti_service
    (fun name () -> (* the page element in wich we will include the canvas *)
       let canvas_box = div []
       in
         (include_canvas name canvas_box;
          Lwt.return
            [ h1 [ pcdata name ]; choose_drawing_form (); canvas_box ]))
  

