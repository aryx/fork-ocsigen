let width = 700
  
let height = 400
  
let draw ctx (color, size, (x1, y1), (x2, y2)) =
  ((let a9749a362 : (< .. > as 'a84e5e852) Js.t = ctx in
    let _ (abfaa2988 : 'a84e5e852) =
      (abfaa2988#strokeStyle : < set : 'a12112916 -> unit; .. > Js.gen_prop)
    in Js.Unsafe.set a9749a362 "strokeStyle" (Js.string color : 'a12112916));
   (let af092c048 : (< .. > as 'aa789d97d) Js.t = ctx in
    let _ (a64f1392a : 'aa789d97d) =
      (a64f1392a#lineWidth : < set : 'a5f6575ba -> unit; .. > Js.gen_prop)
    in Js.Unsafe.set af092c048 "lineWidth" (float size : 'a5f6575ba));
   (let ae822624d : (< .. > as 'a30a5da5a) Js.t = ctx in
    let _ (a023c5a49 : 'a30a5da5a) =
      (a023c5a49#beginPath : 'a3ba5c17b Js.meth)
    in (Js.Unsafe.meth_call ae822624d "beginPath" [|  |] : 'a3ba5c17b));
   (let aa912e399 : (< .. > as 'ae187c619) Js.t = ctx in
    let _ (a927936a6 : 'ae187c619) =
      (a927936a6#moveTo : 'a17ac33ed -> 'a876d6906 -> 'ade15b1f5 Js.meth)
    in
      (Js.Unsafe.meth_call aa912e399 "moveTo"
         [| Js.Unsafe.inject (float x1 : 'a17ac33ed);
           Js.Unsafe.inject (float y1 : 'a876d6906)
         |] :
        'ade15b1f5));
   (let a33f5f750 : (< .. > as 'a9bc37f35) Js.t = ctx in
    let _ (aa9483ccb : 'a9bc37f35) =
      (aa9483ccb#lineTo : 'abc9aab0e -> 'ab2404233 -> 'a83fec944 Js.meth)
    in
      (Js.Unsafe.meth_call a33f5f750 "lineTo"
         [| Js.Unsafe.inject (float x2 : 'abc9aab0e);
           Js.Unsafe.inject (float y2 : 'ab2404233)
         |] :
        'a83fec944));
   let a5b312fad : (< .. > as 'aedbaf2bf) Js.t = ctx in
   let _ (ad71a6f91 : 'aedbaf2bf) = (ad71a6f91#stroke : 'ad3e1c974 Js.meth)
   in (Js.Unsafe.meth_call a5b312fad "stroke" [|  |] : 'ad3e1c974))
  
let _ =
  Eliommod_cli.register_closure (Int64.to_int 569575520L)
    (fun () ->
       let canvas = Dom_html.createCanvas Dom_html.document in
       let ctx =
         let aa30344a2 : (< .. > as 'a61f5ff06) Js.t = canvas in
         let _ (add40663a : 'a61f5ff06) =
           (add40663a#getContext : 'a24be5912 -> 'aec066dc4 Js.meth)
         in
           (Js.Unsafe.meth_call aa30344a2 "getContext"
              [| Js.Unsafe.inject (Dom_html._2d_ : 'a24be5912) |] :
             'aec066dc4)
       in
         ((let a450bcce2 : (< .. > as 'a2305ec3c) Js.t = canvas in
           let _ (ad800defa : 'a2305ec3c) =
             (ad800defa#width : < set : 'a11bb050d -> unit; .. > Js.gen_prop)
           in Js.Unsafe.set a450bcce2 "width" (width : 'a11bb050d));
          (let aebad6cf8 : (< .. > as 'a7f407964) Js.t = canvas in
           let _ (a8886a8ff : 'a7f407964) =
             (a8886a8ff#height :
               < set : 'ad739f74a -> unit; .. > Js.gen_prop)
           in Js.Unsafe.set aebad6cf8 "height" (height : 'ad739f74a));
          (let ac15a0388 : (< .. > as 'a41432fb9) Js.t = ctx in
           let _ (ad916f393 : 'a41432fb9) =
             (ad916f393#lineCap :
               < set : 'a5114d1b5 -> unit; .. > Js.gen_prop)
           in
             Js.Unsafe.set ac15a0388 "lineCap"
               (Js.string "round" : 'a5114d1b5));
          Dom.appendChild
            (let a93219240 : (< .. > as 'a103345e2) Js.t = Dom_html.
               document in
             let _ (ad62eed4e : 'a103345e2) =
               (ad62eed4e#body : < get : 'a82aa3380; .. > Js.gen_prop)
             in (Js.Unsafe.get a93219240 "body" : 'a82aa3380))
            canvas;
          draw ctx ("#ffaa33", 12, (10, 10), (200, 100))))
  

