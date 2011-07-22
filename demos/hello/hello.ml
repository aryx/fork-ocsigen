(* this open is done also internally by eliomc, but if you want to compile
 * without eliomc then you need it (otherwise you'll get a type error, ugly)
 *)
open Eliom_pervasives

(* from the eliom tutorial *)
let coucou =
  Eliom_output.Html5.register_service
    ~path:["coucou"]
    ~get_params:Eliom_parameters.unit
    (fun () () ->
      Lwt.return
        (HTML5.M.html
            (HTML5.M.head (HTML5.M.title (HTML5.M.pcdata "")) [])
            (HTML5.M.body [HTML5.M.h1 [HTML5.M.pcdata "How you doin?"]])))

(* with some open and a counter *)
open HTML5.M
open Eliom_parameters

let count =
  let next =
    let c = ref 0 in
    (fun () -> c := !c + 1; !c)
  in
  Eliom_output.Html5.register_service
    ~path:["count"]
    ~get_params:unit
    (fun () () ->
      Lwt.return
        (html
         (head (title (pcdata "counter")) [])
         (body [p [pcdata (string_of_int (next ()))]])))

