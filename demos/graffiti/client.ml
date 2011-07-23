module Ev = Event_arrows
let (>>>) = Ev.(>>>)

let draw ctx (color, size, (x1, y1), (x2, y2)) =
  ctx##strokeStyle <- (Js.string color);
  ctx##lineWidth <- float size;
  ctx##beginPath();
  ctx##moveTo(float x1, float y1);
  (* The 0.1 is a fix for Chrome
   * (does not draw lines if the first and last points are equal) *
   *)
  ctx##lineTo(float x2, float y2 +. 0.1); 
  ctx##stroke()

let () =
  let c = Eliom_comet.Configuration.new_configuration () in
  Eliom_comet.Configuration.set_active_until_timeout c true

let launch_client_canvas bus imageservice =
  let canvas = Dom_html.createCanvas Dom_html.document in
  canvas##width <- Shared.width; 
  canvas##height <- Shared.height;
  let st = canvas##style in
  st##position <- Js.string "absolute";
  st##zIndex <- Js.string "-1";
  Dom.appendChild Dom_html.document##body canvas;
  let ctx = canvas##getContext (Dom_html._2d_) in
  ctx##lineCap <- Js.string "round";

  (* Another canvas, for second layer *)
  let canvas2 = Dom_html.createCanvas Dom_html.document in
  canvas2##width <- Shared.width; 
  canvas2##height <- Shared.height;
  Dom.appendChild Dom_html.document##body canvas2;
  let ctx2 = canvas2##getContext (Dom_html._2d_) in
  ctx2##lineCap <- Js.string "round";

  (* The initial image: *)
  let img = Dom_html.createImg Dom_html.document in
  img##alt <- Js.string "canvas";
  img##src <- Js.string 
    (Eliom_output.Html5.make_string_uri ~service:imageservice ());
  img##onload <- 
    Dom_html.handler (fun ev -> ctx##drawImage(img, 0., 0.); Js._false);

  (* Size of the brush *)
  let slider = jsnew Goog.Ui.slider(Js.null) in
  slider##setOrientation(Goog.Ui.SliderBase.Orientation._VERTICAL);
  slider##setMinimum(1.);
  slider##setMaximum(80.);
  slider##setValue(10.);
  slider##setMoveToPointEnabled(Js._true);
  slider##render(Js.some Dom_html.document##body);
          
  (* The color palette: *)
  let pSmall = 
(*VVV Problems with HSVA:
 - the widget gives #rrggbbaa and the canvas expects rgba(rrr, ggg, bbb, a)
 - the point between two lines is diaplayed twice (=> darker)
*)
    jsnew Goog.Ui.hsvPalette(Js.null, Js.null,
                            Js.some (Js.string "goog-hsv-palette-sm"))
  in
  pSmall##render(Js.some Dom_html.document##body);

  let x = ref 0 in
  let y = ref 0 in
  let set_coord ev =
    let x0, y0 = Dom_html.elementClientPosition canvas in
    x := ev##clientX - x0; y := ev##clientY - y0 in
  let compute_line set_coord x y ev =
    let oldx = !x and oldy = !y in
    set_coord ev;
    let color = Js.to_string (pSmall##getColor()) in
    let size = int_of_float (Js.to_float (slider##getValue())) in
    (color, size, (oldx, oldy), (!x, !y))
  in
  let line ev =
    let v = compute_line set_coord x y ev in
    let _ = Eliom_bus.write bus v in
    draw ctx v
  in

  ignore (Lwt_js.sleep 0.1 >>= fun () -> (* avoid chromium looping cursor *)
    Lwt.catch
      (fun () -> 
        Lwt_stream.iter (draw ctx) (Eliom_bus.stream bus))
      (function e (* Eliom_comet.Channel_full *) ->
        Firebug.console##log (e);
        Eliom_client.exit_to
          ~service:Eliom_services.void_coservice' () ();
        Lwt.return ()));
  (*                       | e -> Lwt.fail e)); *)
  ignore 
    (Ev.run 
        (Ev.mousedowns canvas2
            (Ev.arr (fun ev -> set_coord ev; line ev)
              >>> Ev.first [Ev.mousemoves Dom_html.document (Ev.arr line);
                            Ev.mouseup Dom_html.document >>> (Ev.arr line)]))
        ());
  
  
  (* The brush *)
  (*VVV bof document.
  Mieux : canvas2 mais il faut gérer la sortie du canvas... *)
  ctx2##globalCompositeOperation <- Js.string "copy";
  let x, y, size = ref 0, ref 0, ref 0 in
  let set_coord ev =
    let x0, y0 = Dom_html.elementClientPosition canvas2 in
    x := ev##clientX - x0; y := ev##clientY - y0 in
  let brush ev =
    let (color, newsize, oldv, v) = compute_line set_coord x y ev in
    draw ctx2 ("rgba(0,0,0,0)", !size+3, oldv, oldv);
    size := newsize;
    draw ctx2 (color, newsize, v, v)
  in
  ignore (Ev.run (Ev.mousemoves Dom_html.document (Ev.arr brush)) ())
    
