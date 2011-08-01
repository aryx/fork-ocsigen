module H = HTML5.M

module App = Eliom_output.Eliom_appl (struct
    let application_name = "app"
end)

let _ = 
  Eliom_state.set_global_volatile_data_state_timeout 
    ~scope:Eliom_common.comet_client_process (Some 20.)

let bus = 
  Eliom_bus.create ~scope:`Global ~name:"grib" ~size:500 
    Json.t<Shared.messages>

let surface = 
  Cairo.image_surface_create Cairo.FORMAT_ARGB32 
    ~width:Shared.width ~height:Shared.height

let image_string () =
  let b = Buffer.create 10000 in
  (* Output a PNG in a string *)
  Cairo_png.surface_write_to_stream surface (Buffer.add_string b);
  Buffer.contents b
  
let draw_server = fun ((color : string), size, (x1, y1), (x2, y2)) ->

  let ctx = Cairo.create surface in

  (* Set thickness of brush *)
  Cairo.set_line_width ctx (float size);
  Cairo.set_line_join ctx Cairo.LINE_JOIN_ROUND;
  Cairo.set_line_cap ctx Cairo.LINE_CAP_ROUND;
  let red, green, blue =  Lib.rgb_from_string color in
  Cairo.set_source_rgb ctx ~red ~green ~blue;
  
  Cairo.move_to ctx (float x1) (float y1);
  Cairo.line_to ctx (float x2) (float y2);
  Cairo.close_path ctx;
  
  (* Apply the ink *)
  Cairo.stroke ctx;
  ()

let _ = Lwt_stream.iter draw_server (Eliom_bus.stream bus)

let imageservice =
  Eliom_output.Text.register_service
    ~path:["image"] ~get_params:Eliom_parameters.unit
   (fun () () -> Lwt.return (image_string (), "image/png"))
