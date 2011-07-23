
let _ = 
  Eliom_state.set_global_volatile_data_state_timeout 
    ~scope:Eliom_common.comet_client_process (Some 20.)

module My_appl =
  Eliom_output.Eliom_appl (struct
    let application_name = "app"
  end)

let bus = Eliom_bus.create ~scope:`Global ~name:"grib" ~size:500 Json.t<Shared.messages>

let draw_server, image_string = 
  let surface = 
    Cairo.image_surface_create Cairo.FORMAT_ARGB32 
      ~width:Shared.width ~height:Shared.height in
  let ctx = Cairo.create surface in
  ((fun ((color : string), size, (x1, y1), (x2, y2)) ->

    (* Set thickness of brush *)
    Cairo.set_line_width ctx (float size) ;
    Cairo.set_line_join ctx Cairo.LINE_JOIN_ROUND ;
    Cairo.set_line_cap ctx Cairo.LINE_CAP_ROUND ;
    let red, green, blue =  Lib.rgb_from_string color in
    Cairo.set_source_rgb ctx ~red ~green ~blue ;

    Cairo.move_to ctx (float x1) (float y1) ;
    Cairo.line_to ctx (float x2) (float y2) ;
    Cairo.close_path ctx ;
    
    (* Apply the ink *)
    Cairo.stroke ctx ;
   ),
   (fun () ->
     let b = Buffer.create 10000 in
     (* Output a PNG in a string *)
     Cairo_png.surface_write_to_stream surface (Buffer.add_string b);
     Buffer.contents b
   ))

let _ = Lwt_stream.iter draw_server (Eliom_bus.stream bus)

let oclosure_script =
    HTML5.M.unique
      (HTML5.M.script
         ~a:[HTML5.M.a_src (HTML5.M.uri_of_string "./app_oclosure.js")]
         (HTML5.M.pcdata ""))

let imageservice =
  Eliom_output.Text.register_service
    ~path:["image"]
    ~get_params:Eliom_parameters.unit
    (fun () () -> Lwt.return (image_string (), "image/png"))
