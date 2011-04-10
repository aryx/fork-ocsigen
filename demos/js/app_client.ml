(* must be the name of the .js file *)
let a84e5e852 : (< .. > as 'abfaa2988) Js.t = Dom_html.window in
let _x (a5f6575ba : 'abfaa2988) =
  (a5f6575ba#alert : 'a12112916 -> 'a9749a362 Js.meth)
in
  (Js.Unsafe.meth_call a84e5e852 "alert"
     [| Js.Unsafe.inject (Js.string "Hello" : 'a12112916) |] :
    'a9749a362)


