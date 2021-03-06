(**************************************************************************)
(*                                                                        *)
(*  This file is part of Calendar.                                        *)
(*                                                                        *)
(*  Copyright (C) 2003-2010 Julien Signoles                               *)
(*                                                                        *)
(*  you can redistribute it and/or modify it under the terms of the GNU   *)
(*  Lesser General Public License version 2.1 as published by the         *)
(*  Free Software Foundation, with a special linking exception (usual     *)
(*  for Objective Caml libraries).                                        *)
(*                                                                        *)
(*  It is distributed in the hope that it will be useful,                 *)
(*  but WITHOUT ANY WARRANTY; without even the implied warranty of        *)
(*  MERCHANTABILITY or FITNESS FOR A PARTICULAR                           *)
(*                                                                        *)
(*  See the GNU Lesser General Public Licence version 2.1 for more        *)
(*  details (enclosed in the file LGPL).                                  *)
(*                                                                        *)
(*  The special linking exception is detailled in the enclosed file       *)
(*  LICENSE.                                                              *)
(**************************************************************************)

(* $Id: example.ml 231 2010-07-05 07:54:31Z signoles $ *)

(** Add a tag @example *)
class example = object (self)
  inherit Odoc_html.html as super

  method html_of_example txt = 
    let buf = Buffer.create 97 in
    self#html_of_text buf txt;
    Format.sprintf "%s<br>\n" (Buffer.contents buf);

  method html_of_examples = function
  | [] -> ""
  | [ txt ] -> Format.sprintf "<b>Example:</b> %s" (self#html_of_example txt)
  | examples ->
      let s = Format.sprintf "<b>Examples:</b><ul>" in
      let s =
	List.fold_left
	  (fun acc txt ->
	     Format.sprintf "%s<li>%s</li>" 
	       acc 
	       (self#html_of_example txt))
	  s
	  examples;
      in
      Format.sprintf "%s</ul>" s

  (** Redefine [html_of_custom] *)
  method html_of_custom b l =
    let examples = ref [] in
    List.iter
      (fun (tag, text) ->
         try
	   if tag = "example" then examples := text :: !examples
	   else assert false
         with
           Not_found ->
             Odoc_info.warning (Odoc_messages.tag_not_handled tag))
      l;
    Buffer.add_string b (self#html_of_examples !examples)

  initializer
    tag_functions <- ("example", self#html_of_example) :: tag_functions
end

let () = 
  Odoc_args.set_doc_generator (Some ((new example) :> Odoc_args.doc_generator))
