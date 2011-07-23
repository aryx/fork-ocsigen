
let draw ctx (color, size, (x1, y1), (x2, y2)) =
  ctx##strokeStyle <- (Js.string color);
  ctx##lineWidth <- float size;
  ctx##beginPath();
  ctx##moveTo(float x1, float y1);
  ctx##lineTo(float x2, float y2 +. 0.1); (* The 0.1 is a fix for Chrome
                                             (does not draw lines if the
                                             first and last points are equal) *)
  ctx##stroke()

let () =
  let c = Eliom_comet.Configuration.new_configuration () in
  Eliom_comet.Configuration.set_active_until_timeout c true
